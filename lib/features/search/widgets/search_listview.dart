import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_freo/features/search/logic/bloc/wiki_search_bloc.dart';
import 'package:wiki_freo/features/search/models/wiki.dart';
import 'package:wiki_freo/features/search/widgets/search_item.dart';

/// [SearchListView] is a StatefulWidget that displays a list of search results
/// from Wikipedia.
///
/// widget.wiki is the input parameter containing the search results.
///
/// [_scrollController] is used to control the scrolling behavior of the [ListView].
///
/// _isScrolledToBottom is a function that checks if the ListView is scrolled
/// to the bottom.
///
/// In the initState method, a scroll listener is added to _scrollController.
///  When the user scrolls to the bottom, it dispatches a [WikiFetchMore] event
/// to the BLoC for loading more results.
///
/// In the build method, it checks if there are search results
/// [wiki]. If there are no results, it displays a message.
///  Otherwise, it displays the search results in a ListView.
///
/// The ListView.builder is used to efficiently create and display the
///  search results.
///
/// Each search result is displayed using the SearchItem widget,
/// passing the corresponding wikiPage from the search results.

class SearchListView extends StatefulWidget {
  const SearchListView({super.key, required this.wiki});

  final Wiki wiki;

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final ScrollController _scrollController = ScrollController();

  bool _isScrolledToBottom() {
    if (_scrollController.position.isScrollingNotifier.value ||
        _scrollController.position.extentAfter < 500) {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_isScrolledToBottom()) {
        // Dispatch a load-more event to your BLoC
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          BlocProvider.of<WikiSearchBloc>(context).add(WikiFetchMore());
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wiki.nodes.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        height: 360,
        width: 399,
        child: const Text('Wikipedia found nothing'),
      );
    }
    return SizedBox(
      height: 360,
      width: 399,
      child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          itemCount: widget.wiki.nodes.length,
          itemBuilder: (context, index) {
            return SearchItem(
              wikiPage: widget.wiki.nodes[index],
            );
          }),
    );
  }
}
