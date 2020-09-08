import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/bloc/news_bloc/news_bloc.dart';
import 'package:todays_news/bloc/search_bloc/search_bloc.dart';
import 'package:todays_news/bloc/settings_bloc/settings_bloc.dart';
import 'package:todays_news/config/theme_provider.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:todays_news/repository/settings_repository.dart';
import 'package:todays_news/screen/home_screen.dart';

class TodaysNews extends StatefulWidget {
  @override
  _TodaysNewsState createState() => _TodaysNewsState();
}

class _TodaysNewsState extends State<TodaysNews> {
  NewsRepository _newsRepository;
  SettingsRepository _settingsRepository;

  @override
  void initState() {
    super.initState();
    _newsRepository ??= RepositoryProvider.of<NewsRepository>(context);
    _settingsRepository ??= RepositoryProvider.of<SettingsRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
              newsRepository: _newsRepository,
              settingsRepository: _settingsRepository),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
              newsRepository: _newsRepository,
              settingsRepository: _settingsRepository),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) =>
              SettingsBloc(settingsRepository: _settingsRepository)
                ..add(SettingEventGetSettings()),
        ),
      ],
      child: Builder(
        builder: (context) =>
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
          if (state is SettingsStateLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: state.themeMode,
              theme: ThemeProvider.getLightTheme(context),
              darkTheme: ThemeProvider.getDarkTheme(context),
              home: HomeScreen(),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
