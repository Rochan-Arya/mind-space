import 'package:flutter/material.dart';
import '../models/user_progress.dart'; // Adjust the import according to your project structure
import '../services/progress_service.dart';

class ProgressPage extends StatelessWidget {
  final String userId; // Pass this userId to the ProgressPage constructor
  final ProgressService _progressService = ProgressService();

  ProgressPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "H E L L O  !!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 169, 169),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      "YOUR PROGRESS :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              StreamBuilder<UserProgress>(
                stream: _progressService
                    .getUserProgress(userId), // Listen for real-time updates
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while waiting
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final userProgress =
                      snapshot.data ?? UserProgress(); // Get user progress data

                  return Container(
                    height: 350,
                    width: 300,
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade900,
                          offset: Offset(5, 5),
                          blurRadius: 15.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade800,
                          offset: Offset(-5, -7),
                          blurRadius: 20.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Meditation Time: ${userProgress.totalMeditationTime} minutes",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 169, 169),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Sessions Completed: ${userProgress.sessionsCompleted}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 169, 169),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Current Streak: ${userProgress.streak} days",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 169, 169),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Favorite Tracks:",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 169, 169),
                          ),
                        ),
                        ...userProgress.favoriteTracks
                            .map((track) => Text(
                                  track,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 169, 169),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
