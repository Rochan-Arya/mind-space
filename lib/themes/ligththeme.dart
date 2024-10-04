import 'package:flutter/material.dart';

ThemeData light_theme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.grey,
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
    ));
