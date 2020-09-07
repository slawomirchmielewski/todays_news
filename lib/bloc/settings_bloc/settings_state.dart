part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsStateLoaded extends SettingsState {
  final String newsLanguage;
  final ThemeMode themeMode;

  SettingsStateLoaded({this.newsLanguage, this.themeMode});

  @override
  List<Object> get props => [newsLanguage, themeMode];
}
