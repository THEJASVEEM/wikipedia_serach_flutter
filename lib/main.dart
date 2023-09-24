import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_freo/features/search/logic/bloc/wiki_search_bloc.dart';
import 'package:wiki_freo/pages/wikisearch_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppView());
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WikiSearchBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0x00000000),
            primary: const Color(0x00000000),
            background: const Color(0xFFF6F6F6),
            primaryContainer: const Color(0xFFFFFFFF),
            onBackground: const Color(0xFFFFFFFF),
            secondaryContainer: const Color(0xFFFFFFFF),
            onSurface: const Color(0xFF000000),
            onSurfaceVariant: const Color(0xFFFFFFFF),
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFFFFF),
            primary: const Color(0xFFFFFFFF),
            background: const Color(0xFF2A2A2A),
            primaryContainer: const Color(0xFFFFFFFF),
            onBackground: const Color(0xFF353535),
            secondaryContainer: const Color(0xFF3A3A3A),
            onSurface: const Color(0xFFFFFFFF),
            onSurfaceVariant: const Color(0xFF000000),
          ),
          useMaterial3: true,
        ),
        home: const WikiSearchPage(),
      ),
    );
  }
}
