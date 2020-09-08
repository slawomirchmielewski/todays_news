part of 'settings_bloc.dart';

///
/// Representing settings event for settings bloc
///
abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingEventGetSettings extends SettingsEvent {}

class SettingsEventSetNewsLanguage extends SettingsEvent {
  final String language;

  SettingsEventSetNewsLanguage({this.language});

  @override
  List<Object> get props => [language];
}

class SettingsEventSetTheme extends SettingsEvent {
  final String theme;

  SettingsEventSetTheme({this.theme});

  @override
  List<Object> get props => [theme];
}
