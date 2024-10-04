import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:mind_space/auth/auth.dart";
import "package:mind_space/pages/home.dart";

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
