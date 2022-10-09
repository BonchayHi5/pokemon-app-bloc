import 'package:flutter/material.dart';


class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    )),
  );
  static final darkTheme = ThemeData.dark();
}