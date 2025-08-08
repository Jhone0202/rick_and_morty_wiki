import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/presentation/pages/character_details_page.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.scrollController,
    required this.characters,
  });

  final ScrollController scrollController;
  final List<CharacterModel> characters;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CharacterDetailsPage(character: character),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 64,
                  backgroundImage: NetworkImage(character.image),
                ),
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Detalhes ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.secondary,
                          ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
