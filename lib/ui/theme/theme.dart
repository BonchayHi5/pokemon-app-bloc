import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}

final appThemeData = {
  AppTheme.light: ThemeData.light(),
  AppTheme.dark: ThemeData.dark(),
};