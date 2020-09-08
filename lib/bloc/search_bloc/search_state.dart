part of 'search_bloc.dart';

///
/// Representing search bloc state
///
abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}
