import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_space/models/playlist_provider.dart';
import 'package:mind_space/pages/progress.dart';
import 'package:mind_space/pages/track.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String _selectedDay = 'Select a day';
  int _currentIndex = 0;

  Map<String, String> schedule = {
    "Mon": "Meditation and Stretching",
    "Tue": "Cardio and Strength Training",
    "Wed": "Yoga and Flexibility",
    "Thurs": "HIIT and Core",
    "Fri": "Weight Lifting",
    "Sat": "Outdoor Running",
    "Sun": "Rest Day & Recovery",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: const Color.fromARGB(255, 255, 169, 169),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              "assets/images/space.png",
              scale: 18,
            ),
            const SizedBox(width: 10),
            const Text(
              "MindSpace",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 169, 169),
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const Spacer(),
            IconButton(
              highlightColor: const Color.fromARGB(255, 255, 169, 169),
              onPressed: () {
                final snackBar = SnackBar(
                  backgroundColor: Colors.grey[850],
                  padding: const EdgeInsets.all(10),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 60, left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Signed In As,"),
                        const SizedBox(height: 30),
                        // Profile Container
                        Container(
                          width: 280,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade900,
                                offset: const Offset(5, 5),
                                blurRadius: 15.0,
                                spreadRadius: 0.4,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade800,
                                offset: const Offset(-8, -8),
                                blurRadius: 20.0,
                                spreadRadius: 0.4,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 169, 169),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(Icons.person),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                user.email!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 169, 169),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          color: const Color.fromARGB(255, 255, 169, 169),
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  duration: const Duration(seconds: 5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(Icons.person),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: _currentIndex == 0
          ? _buildHomeContent(context) // Pass context for the PlaylistProvider
          : _currentIndex == 1
              ? TrackPage(
                  song: null,
                )
              : ProgressPage(
                  userId: user.email!,
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 169, 169),
        backgroundColor: Colors.grey[850],
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Tracks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: "Progress",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 50),
      child: Column(
        children: [
          const Text(
            "Hi, How Are You Feeling Today!!",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(height: 30),
          Container(
            height: 100,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade900,
                  offset: const Offset(5, 5),
                  blurRadius: 15.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.grey.shade800,
                  offset: const Offset(-5, -7),
                  blurRadius: 20.0,
                  spreadRadius: 2.0,
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  children: [
                    _buildEmotionIcon(
                        context,
                        Icons.sentiment_dissatisfied_outlined,
                        "UnHappy",
                        Colors.red),
                    const SizedBox(width: 40),
                    _buildEmotionIcon(context, Icons.sentiment_neutral_outlined,
                        "Normal", Colors.orange),
                    const SizedBox(width: 40),
                    _buildEmotionIcon(
                        context,
                        Icons.sentiment_satisfied_outlined,
                        "Good",
                        Colors.yellow),
                    const SizedBox(width: 40),
                    _buildEmotionIcon(
                        context,
                        Icons.sentiment_very_satisfied_rounded,
                        "Excellent",
                        Colors.green),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
              color: const Color.fromARGB(255, 255, 169, 169), height: 0.6),
          const SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDayContainer("Mon"),
                const SizedBox(width: 20),
                _buildDayContainer("Tue"),
                const SizedBox(width: 20),
                _buildDayContainer("Wed"),
                const SizedBox(width: 20),
                _buildDayContainer("Thurs"),
                const SizedBox(width: 20),
                _buildDayContainer("Fri"),
                const SizedBox(width: 20),
                _buildDayContainer("Sat"),
                const SizedBox(width: 20),
                _buildDayContainer("Sun"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(right: 170),
            child: Text(
              "Today's Schedule:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 169, 169),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 169, 169),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                schedule[_selectedDay] ?? 'Select a day to view the schedule',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionIcon(
      BuildContext context, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => _showEmotionDialog(context, label),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _showEmotionDialog(BuildContext context, String label) {
    final playlistProvider =
        Provider.of<PlaylistProvider>(context, listen: false);
    final suggestedSong = playlistProvider.getSongForEmotion(label);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$label",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(height: 20),
              (label == "Excellent")
                  ? Text(
                      "Great!!Wanna listen to some tracks",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Boost Your Mood With Some Songs",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Go to Tracker",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 169, 169),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to TrackPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackPage(
                      song: suggestedSong,
                    ),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 169, 169),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayContainer(String day) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDay = day;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: const Alignment(0, 0),
          height: 100,
          width: 70,
          decoration: BoxDecoration(
            color: _selectedDay == day
                ? const Color.fromARGB(255, 255, 169, 169)
                : Colors.grey[850],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                offset: const Offset(5, 5),
                blurRadius: 15.0,
                spreadRadius: 0.4,
              ),
              BoxShadow(
                color: Colors.grey.shade800,
                offset: const Offset(-5, -5),
                blurRadius: 20.0,
                spreadRadius: 0.4,
              )
            ],
          ),
          child: Text(
            day,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
