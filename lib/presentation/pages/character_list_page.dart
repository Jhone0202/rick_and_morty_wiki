import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_wiki/presentation/components/character_grid.dart';
import 'package:rick_and_morty_wiki/presentation/components/search_bar_widget.dart';
import 'package:rick_and_morty_wiki/presentation/viewmodels/character_list_viewmodel.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  late CharacterListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<CharacterListViewModel>(context, listen: false);
    _initScrollListener();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _initScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        viewModel.loadCharacters(search: searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (context) => RefreshIndicator(
            onRefresh: () => viewModel.loadCharacters(reset: true),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Rick and Morty Wiki',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Encontre seu personagem favorito usando a Rick and Morty API',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBarWidget(
                    controller: searchController,
                    onSearch: (_) => viewModel.loadCharacters(
                      search: searchController.text,
                      reset: true,
                    ),
                    onClear: () {
                      searchController.clear();
                      viewModel.loadCharacters(reset: true);
                    },
                  ),
                ),
                if (viewModel.isLoading && viewModel.characters.isEmpty)
                  Expanded(
                    child: const Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    ),
                  )
                else if (viewModel.errorMessage.isNotEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: viewModel.loadCharacters,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  )
                else
                  Expanded(
                    child: CharacterGrid(
                      scrollController: scrollController,
                      characters: viewModel.characters,
                    ),
                  ),
                if (viewModel.isLoading && viewModel.characters.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
