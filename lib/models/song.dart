class Song {
  final String songName;
  final String artistName;
  final String albumArtimgPath;
  String? audioUrl; // Will be fetched from Firebase

  Song({
    required this.songName,
    required this.artistName,
    required this.albumArtimgPath,
    this.audioUrl,
  });
}
