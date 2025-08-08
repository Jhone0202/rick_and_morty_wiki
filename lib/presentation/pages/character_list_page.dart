import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_wiki/presentation/pages/character_details_page.dart';
import 'package:rick_and_morty_wiki/presentation/viewmodels/character_list_viewmodel.dart';

class CharacterListPage extends StatelessWidget {
  const CharacterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharacterListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
      ),
      body: Observer(
        builder: (context) => RefreshIndicator(
          onRefresh: viewModel.loadCharacters,
          child: Column(
            children: [
              SearchBar(
                controller: viewModel.searchController,
                onSubmitted: (_) => viewModel.loadCharacters(),
                elevation: WidgetStateProperty.all(0.0),
                hintText: 'Pesquisar personagem',
                leading: const Icon(Icons.search),
                trailing: [
                  if (viewModel.searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        viewModel.searchController.clear();
                        viewModel.loadCharacters();
                      },
                      icon: Icon(Icons.close),
                    ),
                ],
              ),
              if (viewModel.isLoading)
                const Center(
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 1),
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
            ],
          ),
        ),
      ),
    );
  }
}
