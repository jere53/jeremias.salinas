import 'package:flutter/material.dart';

abstract class AppTheme {
  static const double titleSmallFontSize = 26;
  static const double displaySmallFontSize = 13;

  static const double cardBorderRadius = 3;

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Colors.blueGrey.shade900,
      ),
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      primaryColor: Colors.white70,
      primaryColorLight: Colors.blueGrey.shade800,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white70),
      cardColor: Colors.blueGrey.shade800,
      textTheme: TextTheme(
        displaySmall: TextStyle(
          color: Colors.grey.shade300,
          fontSize: displaySmallFontSize,
        ),
        titleSmall: const TextStyle(
          fontSize: titleSmallFontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.black45,
      ),
    );
  }
}
