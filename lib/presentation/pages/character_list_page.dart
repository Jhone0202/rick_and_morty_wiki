import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
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
      body: Observer(builder: (context) {
        if (viewModel.isLoading) {
          return const Center(
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          );
        }

        if (viewModel.errorMessage.isNotEmpty) {
          return Column(
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
          );
        }

        return ListView.builder(
          itemCount: viewModel.characters.length,
          itemBuilder: (context, index) {
            final character = viewModel.characters[index];
            return ListTile(
              onTap: () {},
              title: Text(character.name),
              subtitle: Text('${character.species} - ${character.gender}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(character.image),
              ),
            );
          },
        );
      }),
    );
  }
}
