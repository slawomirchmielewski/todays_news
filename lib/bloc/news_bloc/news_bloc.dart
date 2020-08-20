import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:todays_news/utils/date_converter.dart';

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
        assert(newsRepository != null),
        super(null);

  /// List of news
  List<News> _newses;

  /// Index of the current page in the api
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
      String todayDate = DateConverter.convertDateToString(DateTime.now());

      _newses = await _newsRepository.fetchNews(
          page: _page.toString(), data: todayDate);
    } catch (e) {
      print(e);
    }

    yield _newses;
  }

  Stream<List<News>> _mapNewsEventRefreshNewsToState() async* {
    _page++;

    try {
      String todayDate = DateConverter.convertDateToString(DateTime.now());

      List<News> newses = await _newsRepository.fetchNews(
          page: _page.toString(), data: todayDate);

      for (var n in newses) {
        _newses.add(n);
      }
    } catch (e) {
      print(e);
    }

    yield List.from(_newses);
  }
}
