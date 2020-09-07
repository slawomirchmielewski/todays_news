import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import 'package:todays_news/repository/settings_repository.dart';

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
  SettingsRepository _settingsRepository;

  NewsBloc(
      {@required NewsRepository newsRepository,
      @required SettingsRepository settingsRepository})
      : _newsRepository = newsRepository,
        _settingsRepository = settingsRepository,
        assert(newsRepository != null),
        super(null);

  /// List of news
  List<News> _newses;

  @override
  Stream<List<News>> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is NewsEventFetchNews) {
      yield* _mapNewsEventFetchNewsToState();
    } else if (event is NewsEventRefreshNews) {
      yield* _mapNewsEventRefreshNewsToState();
    } else if (event is NewsEventSortAscendingByData) {
      yield* _mapNewsEventSortAscendingByDataToState();
    } else if (event is NewsEventSortDescendingByData) {
      yield* _mapNewsEventSortDescendingByDataToState();
    }
  }

  Stream<List<News>> _mapNewsEventFetchNewsToState() async* {
    yield await getNews();
  }

  Stream<List<News>> _mapNewsEventRefreshNewsToState() async* {
    yield await getNews();
  }

  Future<List<News>> getNews() async {
    try {
      String language = await _settingsRepository.getNewsLanguage();

      _newses = await _newsRepository.fetchNews(language: language);
    } catch (e) {
      print(e);
    }

    _newses = _newses.where((news) => news.image != "None").toList();

    return _newses;
  }

  Stream<List<News>> _mapNewsEventSortAscendingByDataToState() async* {
    _newses.sort((a, b) => compareNatural(a.author, b.author));
    yield List.from(_newses);
  }

  Stream<List<News>> _mapNewsEventSortDescendingByDataToState() async* {
    _newses.sort((a, b) => compareNatural(b.author, a.author));
    yield List.from(_newses);
  }
}
