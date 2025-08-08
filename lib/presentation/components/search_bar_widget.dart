import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  final TextEditingController controller;
  final Function(String)? onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      onSubmitted: onSearch,
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      elevation: WidgetStateProperty.all(0.0),
      hintText: 'Pesquisar personagem',
      leading: const Icon(
        Icons.search,
        color: AppColors.secondary,
      ),
      backgroundColor: WidgetStatePropertyAll(
        AppColors.backgroundSearch,
      ),
      textStyle: WidgetStateProperty.all(
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary,
            ),
      ),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: onClear,
            icon: Icon(Icons.close),
          ),
      ],
    );
  }
}
