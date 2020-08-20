import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/bloc/news_bloc/news_bloc.dart';
import 'package:todays_news/bloc/search_bloc/search_bloc.dart';
import 'package:todays_news/config/theme_provider.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:todays_news/screen/home_screen.dart';

class TodaysNews extends StatefulWidget {
  @override
  _TodaysNewsState createState() => _TodaysNewsState();
}

class _TodaysNewsState extends State<TodaysNews> {
  NewsRepository _newsRepository;

  @override
  void initState() {
    super.initState();
    _newsRepository ??= RepositoryProvider.of<NewsRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(newsRepository: _newsRepository),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(newsRepository: _newsRepository),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeProvider.getLightTheme(context),
        darkTheme: ThemeProvider.getDarkTheme(context),
        home: HomeScreen(),
      ),
    );
  }
}
