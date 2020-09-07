import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todays_news/utils/theme_converter.dart';

class SettingsRepository {
  final String _languageShort = "language";
  final String _theme = "theme";

  Future<String> getNewsLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String language = prefs.getString(_languageShort);

    return language ?? "en";
  }

  Future<void> saveNewsLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageShort, language);
  }

  Future<void> saveThemeMode(String themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_theme, themeMode);
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String theme = prefs.getString(_theme);

    return ThemeConverter.stringToTheme(theme);
  }
}
