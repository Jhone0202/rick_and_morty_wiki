// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/presentation/components/character_species_chip.dart';
import 'package:rick_and_morty_wiki/presentation/components/character_status_chip.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(character.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              character.name,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CharacterStatusChip(status: character.status),
              const SizedBox(width: 8),
              CharacterSpeciesChip(species: character.species),
            ],
          ),
        ],
      ),
    );
  }
}
