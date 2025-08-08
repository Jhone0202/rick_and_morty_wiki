import 'package:mobx/mobx.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_interface.dart';

part 'character_list_viewmodel.g.dart';

class CharacterListViewModel = ICharacterListViewModel
    with _$CharacterListViewModel;

abstract class ICharacterListViewModel with Store {
  final ICharacterRepository repository;

  ICharacterListViewModel(this.repository) {
    loadCharacters();
  }

  @observable
  ObservableList<CharacterModel> characters = ObservableList();

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @observable
  int currentPage = 1;

  @observable
  bool hasMore = true;

  @action
  Future loadCharacters({String search = '', bool reset = false}) async {
    try {
      if (reset) {
        currentPage = 1;
        characters.clear();
        hasMore = true;
      }

      if (!hasMore || isLoading) return;

      isLoading = true;
      errorMessage = '';

      final newCharacters = await repository.getCharacters(
        search: search,
        page: currentPage,
      );

      if (newCharacters.isEmpty) {
        hasMore = false;
      } else {
        characters.addAll(newCharacters);
        currentPage++;
      }
    } catch (e) {
      errorMessage = e.toString();
      hasMore = false;
    } finally {
      isLoading = false;
    }
  }
}
