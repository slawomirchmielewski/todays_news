import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todays_news/model/news.dart';
import 'package:todays_news/repository/news_repository.dart';
import 'package:meta/meta.dart';
import 'package:todays_news/utils/date_converter.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, List<News>> {
  NewsRepository _newsRepository;

  SearchBloc({@required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        assert(newsRepository != null),
        super([]);

  /// List of news
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
    }
  }

  Stream<List<News>> _mapSearchEventQueryNewsToState(String query) async* {
    try {
      if (query != "") {
        String todayDate = DateConverter.convertDateToString(DateTime.now());

        _newses = await _newsRepository.fetchNews(
            q: query, page: 1.toString(), data: todayDate);

        yield _newses;
      } else {
        yield [];
      }
    } catch (e) {
      print(e);
    }
  }
}
