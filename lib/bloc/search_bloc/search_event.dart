part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEventQueryNews extends SearchEvent {
  final String query;

  SearchEventQueryNews({this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => "Query news {$query}";
}

class SearchEventClearList extends SearchEvent {}
