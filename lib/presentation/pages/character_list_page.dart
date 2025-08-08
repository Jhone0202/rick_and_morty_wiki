import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_wiki/presentation/pages/character_details_page.dart';
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
                  padding: const EdgeInsets.all(16),
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
                  child: SearchBar(
                    controller: searchController,
                    onSubmitted: (_) => viewModel.loadCharacters(
                      search: searchController.text,
                      reset: true,
                    ),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    elevation: WidgetStateProperty.all(0.0),
                    hintText: 'Pesquisar personagem',
                    leading: const Icon(Icons.search),
                    trailing: [
                      if (searchController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            searchController.clear();
                            viewModel.loadCharacters(reset: true);
                          },
                          icon: Icon(Icons.close),
                        ),
                    ],
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
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: viewModel.characters.length,
                      itemBuilder: (context, index) {
                        final character = viewModel.characters[index];
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CharacterDetailsPage(
                                character: character,
                              ),
                            ),
                          ),
                          title: Text(character.name),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(character.image),
                          ),
                        );
                      },
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
