import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todays_news/repository/settings_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, List<News>> {
  NewsRepository _newsRepository;
  SettingsRepository _settingsRepository;

  SearchBloc(
      {@required NewsRepository newsRepository,
      @required SettingsRepository settingsRepository})
      : _newsRepository = newsRepository,
        _settingsRepository = settingsRepository,
        assert(newsRepository != null),
        super([]);

  List<News> _newses = [];

  @override
  Stream<Transition<SearchEvent, List<News>>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    final debounceStream = events.where((event) {
      return (event is SearchEventQueryNews);
    }).debounceTime(Duration(milliseconds: 500));

    return super.transformEvents(debounceStream, transitionFn);
  }

  @override
  Stream<List<News>> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchEventQueryNews) {
      yield* _mapSearchEventQueryNewsToState(event.query);
    } else if (event is SearchEventClearList) {
      yield* _mapSearchEventClearListToState();
    }
  }

  Stream<List<News>> _mapSearchEventQueryNewsToState(String query) async* {
    try {
      if (query != "") {
        String language = await _settingsRepository.getNewsLanguage();

        _newses =
            await _newsRepository.searchNews(query: query, language: language);

        _newses = _newses.where((news) => news.image != "None").toList();

        yield _newses;
      } else {
        yield [];
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<List<News>> _mapSearchEventClearListToState() async* {
    _newses = [];

    print("hello");
    yield List.from(_newses);
  }
}
