import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    fontFamily: 'Georgia',
    scaffoldBackgroundColor: const Color(0xFF20120B),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3A2415),
      elevation: 0,
      centerTitle: false,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFF2C94C),
      secondary: Color(0xFFD5B27A),
    ),
  );
}