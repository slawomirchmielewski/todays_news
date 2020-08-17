import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_news/bloc/simple_bloc_observer.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:todays_news/todays_news.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();

  setSystemUI();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsRepository>(
          create: (context) => NewsRepository(),
        )
      ],
      child: TodaysNews(),
    ),
  );
}

void setSystemUI() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}
