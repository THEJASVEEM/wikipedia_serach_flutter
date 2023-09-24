import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_freo/features/search/logic/bloc/wiki_search_bloc.dart';

/// [SearchTextField] is a StatefulWidget that represents a search input field.
///
/// [_debounceTimer] is used to debounce text input, which means that it delays
/// making a search request until the user has finished typing for a certain
/// duration (500 milliseconds in this case).
///
/// In the build method, a [TextFormField] widget is used to create the search
/// input field. It listens for changes in the input value using the onChanged callback.
///
/// When the user types, _debounceTimer?.cancel() is called to cancel
/// any existing debounce timer.
///
/// If the input value is empty, a [ClearSearch] event is dispatched to the
///  [WikiSearchBloc], indicating that the search should be cleared.
///
/// If the input value is not empty, a new debounce timer is started with a
///  500-millisecond delay. When the timer expires, a WikiSearchQuery event
/// is dispatched to the WikiSearchBloc with the search query.

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        cursorHeight: 20,
        cursorColor: const Color(0xFF8D8D8D),
        onChanged: (value) {
          _debounceTimer?.cancel();
          if (value.isEmpty) {
            BlocProvider.of<WikiSearchBloc>(context).add(ClearSearch());
            return;
          }
          // Start a new timer to perform an action after a delay
          _debounceTimer = Timer(const Duration(milliseconds: 500), () {
            BlocProvider.of<WikiSearchBloc>(context)
                .add(WikiSearchQuery(value));
          });
        },
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search wikipedia',
          hintStyle: const TextStyle(
            color: Color(0xFF8D8D8D),
          ),

          filled: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(31),
          ),
          prefixIcon:
              const Icon(Icons.search_rounded, color: Color(0xFF8D8D8D)),
          isDense: true,
        ),
      ),
    );
  }
}
