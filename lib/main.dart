import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mind_space/mainpage.dart';
import 'package:mind_space/models/playlist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => PlaylistProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}
