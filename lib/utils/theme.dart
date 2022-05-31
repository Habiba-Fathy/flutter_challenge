import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF7A348D),
    shadowColor: const Color(0xFFC0C1CD),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: 'Cairo',
    textTheme: TextTheme(
      headline1: TextStyle(
        // color: Color(0xFFC0C1CD),
        color: Colors.grey[400],
      ),
      headline2: const TextStyle(
        color: Color(0xFFFFFFFF),
      ),
      headline3: const TextStyle(
        color: Color(0xFF9E9EAE),
      ),
    ),
  );
}
