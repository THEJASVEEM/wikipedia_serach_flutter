import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';
import 'package:wiki_freo/features/search/models/wiki.dart';
import 'package:wiki_freo/features/search/service/wiki_service.dart';

part 'wiki_search_event.dart';
part 'wiki_search_state.dart';

// Create a BLoC class named WikiSearchBloc
class WikiSearchBloc extends Bloc<WikiSearchEvent, WikiSearchState> {
  WikiSearchBloc() : super(WikiSearchInitial()) {
    // Initialize offset, hasNext, and query variables
    num offset = 0;
    bool hasNext = false;
    String query = '';

    /// Listen to the WikiSearchQuery event i.e. whenever [SearchTextField]
    /// onChanged is called.
    /// Passing the query or search String in the event emits WikiSearchLoading
    /// initially and calls the fetch function.
    /// Accordingly emits WikiSearchLoaded or WikiSearchError

    on<WikiSearchQuery>((event, emit) async {
      offset = 0;

      emit(WikiSearchLoading());

      try {
        final wikiResult =
            await WikiSearchService.fetchPages(event.query, offset);
        offset = wikiResult.offset;
        hasNext = wikiResult.hasNext;
        query = event.query;
        emit(WikiSearchLoaded(wikiResult));
        return;
      } on Exception catch (_) {
        emit(WikiSearchError('Something went wrong, please try again'));
      }
    });

    /// Listen to the WikiFetchMore event i.e. whenever [SearchTextField]
    /// ScrollController listener reaches maxScrollExtent is called.
    /// Accordingly emits WikiSearchLoaded or WikiSearchError

    on<WikiFetchMore>((event, emit) async {
      if (hasNext && offset != 0) {
        try {
          final wikiFetchMore =
              await WikiSearchService.fetchPages(query, offset);
          offset = wikiFetchMore.offset;
          hasNext = wikiFetchMore.hasNext;
          wikiFetchMore.nodes = [
            ...(state as WikiSearchLoaded).wikiResult.nodes,
            ...wikiFetchMore.nodes
          ];
          emit(WikiSearchLoaded(wikiFetchMore));
          return;
        } on Exception catch (_) {
          emit(WikiSearchError('Something went wrong, please try again'));
        }
      }
    });

    /// Listen to the ClearSearch event i.e. whenever [SearchTextField]
    /// onChanged value is empty and clears the variables

    on<ClearSearch>((event, emit) async {
      offset = 0;
      hasNext = false;
      query = '';
      emit(WikiSearchInitial());
    });
  }
}
