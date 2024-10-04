import 'package:flutter/material.dart';
import '../models/user_progress.dart';

class ProgressDisplay extends StatelessWidget {
  final UserProgress progress;

  ProgressDisplay(this.progress);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Total Meditation Time: ${progress.totalMeditationTime} minutes"),
        Text("Sessions Completed: ${progress.sessionsCompleted}"),
        Text("Current Streak: ${progress.streak} days"),
        Text("Favorite Tracks: ${progress.favoriteTracks.join(", ")}"),
      ],
    );
  }
}
