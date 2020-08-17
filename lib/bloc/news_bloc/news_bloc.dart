import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

///
/// Representing news bloc where are the news are getting from the
/// [_newsRepository]
///
/// [_newsRepository] is required and cant be null
///
class NewsBloc extends Bloc<NewsEvent, List<News>> {
  NewsRepository _newsRepository;

  NewsBloc({@required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(null);

  List<News> _newses;

  int _page = 1;

  @override
  Stream<List<News>> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is NewsEventFetchNews) {
      yield* _mapNewsEventFetchNewsToState();
    } else if (event is NewsEventRefreshNews) {
      yield* _mapNewsEventRefreshNewsToState();
    }
  }

  Stream<List<News>> _mapNewsEventFetchNewsToState() async* {
    try {
      String todayDate =
          _convertDateToString(DateTime.now().add(Duration(days: -1)));

      var response = await _newsRepository.fetchNews(
          page: _page.toString(), data: todayDate);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body)["articles"] as List;

        List<News> newses = result.map((e) => News.fromJson(e)).toList();
        _newses = List.from(newses);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    yield _newses;
  }

  Stream<List<News>> _mapNewsEventRefreshNewsToState() async* {
    _page++;

    try {
      String todayDate = _convertDateToString(DateTime.now());

      var response = await _newsRepository.fetchNews(
          page: _page.toString(), data: todayDate);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body)["articles"] as List;

        List<News> newses = result.map((e) => News.fromJson(e)).toList();
        for (var n in newses) {
          _newses.add(n);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    yield List.from(_newses);
  }

  String _convertDateToString(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, "0");
    String month = dateTime.month.toString().padLeft(2, "0");
    String day = dateTime.day.toString().padLeft(2, "0");

    print("$year-$month-$day");

    return "$year-$month-$day";
  }
}
