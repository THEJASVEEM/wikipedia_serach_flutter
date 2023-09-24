part of 'wiki_search_bloc.dart';

@immutable
sealed class WikiSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// This class represents an event where the
/// user initiates a new search query.
class WikiSearchQuery extends WikiSearchEvent {
  final String query;

  WikiSearchQuery(this.query);

  @override
  List<Object> get props => [query];
}

/// This class represents an event where the user requests
///  to fetch more search results i.e whenever user scrolls to the bottom.
class WikiFetchMore extends WikiSearchEvent {
  WikiFetchMore();

  @override
  List<Object> get props => [];
}

/// This class represents an event where the
/// user requests to clear the search results.
class ClearSearch extends WikiSearchEvent {
  @override
  List<Object> get props => [];
}
