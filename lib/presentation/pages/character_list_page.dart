import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_wiki/core/theme/app_colors.dart';
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
                    child: GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: viewModel.characters.length,
                      itemBuilder: (context, index) {
                        final character = viewModel.characters[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CharacterDetailsPage(
                                character: character,
                              ),
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
                                  backgroundImage:
                                      NetworkImage(character.image),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
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
