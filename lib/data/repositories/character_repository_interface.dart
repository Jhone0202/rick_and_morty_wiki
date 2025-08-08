import 'package:rick_and_morty_wiki/data/models/character_model.dart';

abstract class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters({String search = ''});
}
