import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todays_news/repository/settings_repository.dart';
import 'package:meta/meta.dart';
import 'package:todays_news/utils/theme_converter.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsRepository _settingsRepository;

  SettingsBloc({@required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(SettingsInitial());

  String _newLanguage;
  ThemeMode _theme;

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingEventGetSettings) {
      yield* _mapSettingEventGetSettingsToState();
    } else if (event is SettingsEventSetNewsLanguage) {
      yield* _mapSettingsEventSetNewsLanguageToState(event.language);
    } else if (event is SettingsEventSetTheme) {
      yield* _mapSettingsEventSetThemeState(event.theme);
    }
  }

  Stream<SettingsState> _mapSettingEventGetSettingsToState() async* {
    try {
      _newLanguage = await _settingsRepository.getNewsLanguage();
      _theme = await _settingsRepository.getThemeMode();

      yield SettingsStateLoaded(newsLanguage: _newLanguage, themeMode: _theme);
    } catch (e) {
      print(e);
    }
  }

  Stream<SettingsState> _mapSettingsEventSetNewsLanguageToState(
      String language) async* {
    await _settingsRepository.saveNewsLanguage(language);

    _newLanguage = language;

    yield SettingsStateLoaded(newsLanguage: _newLanguage, themeMode: _theme);
  }

  Stream<SettingsState> _mapSettingsEventSetThemeState(String theme) async* {
    await _settingsRepository.saveThemeMode(theme);
    yield SettingsStateLoaded(
        newsLanguage: _newLanguage,
        themeMode: ThemeConverter.stringToTheme(theme));
  }
}
