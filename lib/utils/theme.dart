import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF7A348D),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFFC0C1CD),
      ),
      headline2: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}
