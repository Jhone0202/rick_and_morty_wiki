import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_http.dart';
import 'package:rick_and_morty_wiki/presentation/pages/character_list_page.dart';
import 'package:rick_and_morty_wiki/presentation/viewmodels/character_list_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<CharacterListViewModel>(
      create: (_) => CharacterListViewModel(CharacterRepositoryHttp()),
      child: MaterialApp(
        title: 'Rick and Morty Wiki',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CharacterListPage(),
      ),
    );
  }
}
