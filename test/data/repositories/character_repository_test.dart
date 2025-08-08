import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:rick_and_morty_wiki/core/network/http_client.dart';
import 'package:rick_and_morty_wiki/data/models/character_model.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_http.dart';
import 'package:rick_and_morty_wiki/data/repositories/character_repository_interface.dart';

import '../../mocks/dio_response_mock.dart';

void main() {
  group('CharacterRepositoryHttp', () {
    late ICharacterRepository repository;

    setUp(() {
      repository = CharacterRepositoryHttp();
    });

    test('should return a list of CharacterModel from API', () async {
      HttpClient.rickapi.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final response = mockCharacterResponse(options);
            return handler.resolve(response);
          },
        ),
      );

      final characters = await repository.getCharacters();

      expect(characters, isA<List<CharacterModel>>());
      expect(characters.length, 1);
      expect(characters.first.name, 'Rick Sanchez');
    });
  });
}
