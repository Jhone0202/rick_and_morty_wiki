import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_interface.dart';

class CharacterRepositoryMock extends Mock implements ICharacterRepository {}

final fakeCharacter = CharacterModel(
  id: 1,
  name: 'Rick Sanchez',
  status: 'Alive',
  species: 'Human',
  gender: 'Male',
  image: '',
  created: DateTime.now(),
);
