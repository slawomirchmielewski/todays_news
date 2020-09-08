import 'package:flutter/material.dart';

///
/// Helper class to convert the ThemeMode to String and reverse
///
class ThemeConverter {
  static const _light = "Light";
  static const _dark = "Dark";
  static const _system = "System";

  static String themeToString(ThemeMode themeMode) {
    String theme;

    switch (themeMode) {
      case ThemeMode.light:
        theme = _light;
        break;
      case ThemeMode.system:
        theme = _system;
        break;
      case ThemeMode.dark:
        theme = _dark;
        break;
    }

    return theme;
  }

  static ThemeMode stringToTheme(String themeRef) {
    ThemeMode themeMode;

    switch (themeRef) {
      case _dark:
        themeMode = ThemeMode.dark;
        break;
      case _light:
        themeMode = ThemeMode.light;
        break;
      case _system:
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.system;
        break;
    }

    return themeMode;
  }
}
