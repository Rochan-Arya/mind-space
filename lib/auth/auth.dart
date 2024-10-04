import 'package:flutter/material.dart';
import 'package:mind_space/pages/loginpage.dart';
import 'package:mind_space/pages/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Loginpage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
