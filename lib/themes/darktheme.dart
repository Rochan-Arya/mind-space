import 'package:flutter/material.dart';

ThemeData dark_theme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
    ),
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
    ));
