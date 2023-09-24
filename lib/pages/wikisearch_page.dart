import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_freo/features/search/logic/bloc/wiki_search_bloc.dart';
import 'package:wiki_freo/features/search/widgets/search_listview.dart';
import 'package:wiki_freo/features/search/widgets/search_textfield.dart';

/// [WikiSearchPage] is a StatefulWidget representing the main page of your app
/// for searching Wikipedia content.
///
/// The [AppBar] is set with some system overlay styles to make it transparent.
///
/// The page's body is wrapped in a SafeArea to ensure content is displayed
/// safely within device constraints.
///
/// The main content consists of a title, an image, a search text field,
/// and a [BlocBuilder] to handle different states of the search.
///
/// The [BlocBuilder] listens to the state changes from the [WikiSearchBloc]
/// and displays different UI components based on the current state:
///
/// When in the initial state ([WikiSearchInitial]), it displays a message to
/// "Enter a search query."
/// When loading ([WikiSearchLoading]), it shows a loading indicator.
/// When loaded ([WikiSearchLoaded]), it displays search results using
/// the [SearchListView] widget.
/// When an error occurs ([WikiSearchError]), it shows an error message.
///
/// This page provides a user-friendly interface for searching Wikipedia content,
/// and it dynamically updates based on the search state using the BlocBuilder.

class WikiSearchPage extends StatefulWidget {
  const WikiSearchPage({super.key});

  @override
  State<WikiSearchPage> createState() => _WikiSearchPageState();
}

class _WikiSearchPageState extends State<WikiSearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Wiki Search',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.8)),
                ),
                Image.asset(
                  'assets/images/wiki-logo-transparent.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SearchTextField(),
                BlocBuilder<WikiSearchBloc, WikiSearchState>(
                  bloc: BlocProvider.of<WikiSearchBloc>(context),
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case WikiSearchInitial:
                        return Container(
                          alignment: Alignment.topCenter,
                          height: 360,
                          width: 399,
                          child: const Text('Search anything...'),
                        );
                      case WikiSearchLoading:
                        return Container(
                          alignment: Alignment.topCenter,
                          height: 360,
                          width: 399,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white.withOpacity(0.8),
                          ),
                        );
                      case WikiSearchLoaded:
                        return SearchListView(
                            wiki: (state as WikiSearchLoaded).wikiResult);
                      case WikiSearchError:
                        return Container(
                            alignment: Alignment.topCenter,
                            height: 360,
                            width: 399,
                            child: Text((state as WikiSearchError).message));
                      default:
                        return const Center(
                            child: Text('Enter a search query'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
