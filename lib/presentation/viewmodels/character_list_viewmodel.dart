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
  List<CharacterModel> characters = [];

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @action
  Future loadCharacters({String search = ''}) async {
    try {
      isLoading = true;
      errorMessage = '';
      characters = await repository.getCharacters(search: search);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
