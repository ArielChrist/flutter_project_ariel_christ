import 'package:flutter/material.dart';
import 'package:flutter_project_ariel_christ/utils/constantes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColorlight,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: primaryColorlight,
        elevation: 0,
      ),
      cardColor: cardColorlight,
      cardTheme: CardTheme(
        color: cardColorlight,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColorlight,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: secondaryColorlight,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColorlight,
        secondary: secondaryColorlight,
      ),
    );
  }

  static ThemeData get darkTheme {

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColordark,
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: cardColordark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardColor: cardColordark,
      cardTheme: CardTheme(
        color: cardColordark,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColordark,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: secondaryColordark,
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColordark,
        secondary: secondaryColordark,
      ),
    );
  }
}