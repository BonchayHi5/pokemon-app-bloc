import 'package:flutter/material.dart';


class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    )),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Colors.blue[900]!,width: 3)),
    )
  );
  static final darkTheme = ThemeData.dark();
}