import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mind_space/models/song.dart';
import 'package:mind_space/services/progress_service.dart';
import 'package:mind_space/models/user_progress.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playList = [
    Song(
      songName: "Peaceful Garden",
      artistName: "HarumachiMusic",
      albumArtimgPath: "assets/images/r1.webp",
    ),
    Song(
      songName: "Meditative Rain",
      artistName: "SoundsForYou",
      albumArtimgPath: "assets/images/r2.jpg",
    ),
    Song(
      songName: "Ambient Relax Sound",
      artistName: "Good_B_Music",
      albumArtimgPath: "assets/images/r3.jpg",
    ),
    Song(
      songName: "Meditation Blue",
      artistName: "Imaginedragon",
      albumArtimgPath: "assets/images/r4.webp",
    ),
    Song(
      songName: "Mindfulness",
      artistName: "Jhon Kensy",
      albumArtimgPath: "assets/images/r5.jpeg",
    ),
    Song(
      songName: "Healing",
      artistName: "Denis-Pavlov-Music",
      albumArtimgPath: "assets/images/r6.jpeg",
    ),
    Song(
      songName: "Inspiring",
      artistName: "Saavane",
      albumArtimgPath: "assets/images/r7.jpeg",
    ),
    Song(
      songName: "Meditation Suite",
      artistName: "officeMIKADO",
      albumArtimgPath: "assets/images/r8.jpg",
    ),
    Song(
      songName: "Slow Meditation",
      artistName: "Ashot-Danielyan-Composer",
      albumArtimgPath: "assets/images/r9.jpeg",
    ),
    Song(
      songName: "Dim Meditation",
      artistName: "Dimedia",
      albumArtimgPath: "assets/images/r10.jpg",
    ),
  ];

  int? _currentSongIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ProgressService _progressService = ProgressService();
  UserProgress userProgress = UserProgress();

  PlaylistProvider() {
    listentoDuration();
    loadSongUrls();
  }

  Future<void> loadSongUrls() async {
    try {
      for (int i = 0; i < _playList.length; i++) {
        String songName = _playList[i].songName;
        String audioUrl =
            await _storage.ref('audio/$songName.mp3').getDownloadURL();
        _playList[i].audioUrl = audioUrl;
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching audio URLs: $e");
    }
  }

  void play() async {
    final String? audioUrl = _playList[_currentSongIndex!].audioUrl;
    if (audioUrl != null) {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(audioUrl));
      _isPlaying = true;
      notifyListeners();
    } else {
      print("Audio URL is not available");
    }
  }

  // Pause the song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // Resume the song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Toggle play/pause
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  // Seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  // Play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playList.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  // Play previous song
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      return;
    } else {
      if (currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playList.length - 1;
      }
    }
  }

  // Listen to duration changes
  void listentoDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      completeSession("your_user_id_here", _currentDuration,
          _playList[_currentSongIndex!].songName);
      playNextSong();
    });
  }

  // Complete a meditation session
  void completeSession(
      String userId, Duration sessionDuration, String trackName) {
    userProgress.totalMeditationTime += sessionDuration.inMinutes;
    userProgress.sessionsCompleted += 1;

    if (isNewDay()) {
      userProgress.streak += 1;
    }

    // Update favorite tracks
    if (!userProgress.favoriteTracks.contains(trackName)) {
      userProgress.favoriteTracks.add(trackName);
    }

    // Save progress to Firestore
    _progressService.saveUserProgress(userId, userProgress);
    notifyListeners(); // Notify listeners for UI updates
  }

  // Load user progress
  Future<void> loadUserProgress(String userId) async {
    userProgress =
        (await _progressService.getUserProgress(userId)) as UserProgress;
    notifyListeners();
  }

  bool isNewDay() {
    return true; // Implement actual logic to check for new day
  }

  // Getters
  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setters
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }

  Song? getRandomSong(String emotion) {
    List<Song> filteredSongs = [];

    switch (emotion) {
      case "UnHappy":
        filteredSongs = _playList
            .where((song) =>
                song.songName.contains("Healing") ||
                song.songName.contains("Meditation") ||
                song.songName.contains("Calm"))
            .toList();
        break;
      case "Normal":
        filteredSongs = _playList
            .where((song) =>
                song.songName.contains("Peaceful") ||
                song.songName.contains("Ambient"))
            .toList();
        break;
      case "Good":
        filteredSongs = _playList
            .where((song) =>
                song.songName.contains("Inspiring") ||
                song.songName.contains("Mindfulness"))
            .toList();
        break;
      case "Excellent":
        filteredSongs = _playList
            .where((song) =>
                song.songName.contains("Meditation Suite") ||
                song.songName.contains("Slow Meditation"))
            .toList();
        break;
      default:
        filteredSongs = _playList;
        break;
    }

    if (filteredSongs.isNotEmpty) {
      final randomIndex = Random().nextInt(filteredSongs.length);
      return filteredSongs[randomIndex];
    } else {
      return null;
    }
  }

  getSongForEmotion(String label) {
    // Implement functionality based on your app's needs
  }
}
