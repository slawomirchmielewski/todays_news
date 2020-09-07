part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsEventFetchNews extends NewsEvent {}

class NewsEventRefreshNews extends NewsEvent {}

class NewsEventSortAscendingByData extends NewsEvent {}

class NewsEventSortDescendingByData extends NewsEvent {}
