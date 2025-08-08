import 'package:rick_and_morty_wiki/core/network/http_client.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_interface.dart';

class CharacterRepositoryHttp implements ICharacterRepository {
  @override
  Future<List<CharacterModel>> getCharacters({String search = ''}) async {
    final queryParams = {
      if (search.isNotEmpty) 'name': search,
    };

    final res = await HttpClient.rickapi.get(
      '/character?page=1',
      queryParameters: queryParams,
    );

    if (res.statusCode != 200) {
      throw Exception('Erro ao buscar personagens');
    }

    return (res.data['results'] as List)
        .map((e) => CharacterModel.fromMap(e))
        .toList();
  }
}
