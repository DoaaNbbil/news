import 'package:flutter/material.dart';
import 'package:news/colorsapp.dart';

class Apptheme {
  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colorsapp.black,
      foregroundColor: Colorsapp.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colorsapp.white,
      ),
    ),
    scaffoldBackgroundColor: Colorsapp.black,
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Colorsapp.white,
      ),
    ),
  );
}
