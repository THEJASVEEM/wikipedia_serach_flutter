part of 'wiki_search_bloc.dart';

@immutable
sealed class WikiSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

final class WikiSearchInitial extends WikiSearchState {}

final class WikiSearchLoading extends WikiSearchState {}

final class WikiSearchLoaded extends WikiSearchState {
  final Wiki wikiResult;

  WikiSearchLoaded(this.wikiResult);

  @override
  List<Object> get props => [wikiResult];
}

final class WikiSearchError extends WikiSearchState {
  final String message;

  WikiSearchError(this.message);

  @override
  List<Object> get props => [message];
}
