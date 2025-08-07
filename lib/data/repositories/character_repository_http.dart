import 'package:rick_and_morty_wiki/core/network/http_client.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_interface.dart';

class CharacterRepositoryHttp implements ICharacterRepository {
  final _baseUrl = 'https://rickandmortyapi.com/api/character';

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final res = await HttpClient.client.get(_baseUrl);

    if (res.statusCode != 200) {
      throw Exception('Erro ao buscar personagens');
    }

    return (res.data['results'] as List)
        .map((e) => CharacterModel.fromMap(e))
        .toList();
  }
}
