import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';

class CharacterStatusChip extends StatelessWidget {
  final String status;

  const CharacterStatusChip({super.key, required this.status});

  Color _getColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.secondary;
      case 'dead':
        return Colors.red[800]!;
      default:
        return Colors.amber[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(status);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
