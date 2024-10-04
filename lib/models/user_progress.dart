// models/user_progress.dart
class UserProgress {
  int totalMeditationTime; // in minutes
  int sessionsCompleted;
  int streak;
  List<String> favoriteTracks;

  UserProgress({
    this.totalMeditationTime = 0,
    this.sessionsCompleted = 0,
    this.streak = 0,
    List<String>? favoriteTracks,
  }) : favoriteTracks = favoriteTracks ?? [];

  factory UserProgress.fromMap(Map<String, dynamic> data) {
    return UserProgress(
      totalMeditationTime: data['totalMeditationTime'] ?? 0,
      sessionsCompleted: data['sessionsCompleted'] ?? 0,
      streak: data['streak'] ?? 0,
      favoriteTracks: List<String>.from(data['favoriteTracks'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalMeditationTime': totalMeditationTime,
      'sessionsCompleted': sessionsCompleted,
      'streak': streak,
      'favoriteTracks': favoriteTracks,
    };
  }
}
