import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';

class CharacterSpeciesChip extends StatelessWidget {
  const CharacterSpeciesChip({
    super.key,
    required this.species,
  });
  final String species;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          species,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
