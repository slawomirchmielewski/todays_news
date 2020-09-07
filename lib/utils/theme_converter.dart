import 'package:flutter/material.dart';

class ThemeConverter {
  static String themeToString(ThemeMode themeMode) {
    String theme;

    switch (themeMode) {
      case ThemeMode.light:
        theme = "light";
        break;
      case ThemeMode.system:
        theme = "system";
        break;
      case ThemeMode.dark:
        theme = "dark";
        break;
    }

    return theme;
  }

  static ThemeMode stringToTheme(String themeRef) {
    ThemeMode themeMode;

    switch (themeRef) {
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      case "light":
        themeMode = ThemeMode.light;
        break;
      case "system":
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.system;
        break;
    }

    return themeMode;
  }
}
