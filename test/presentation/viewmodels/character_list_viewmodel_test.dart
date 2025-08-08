import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_wiki/presentation/viewmodels/character_list_viewmodel.dart';

import '../../mocks/character_repository_mock.dart';

void main() {
  late CharacterRepositoryMock repositoryMock;
  late CharacterListViewModel viewModel;

  setUp(() {
    repositoryMock = CharacterRepositoryMock();
    viewModel = CharacterListViewModel(repositoryMock);
  });

  test('Should load characters and update state', () async {
    when(
      () => repositoryMock.getCharacters(page: 1, search: any(named: 'search')),
    ).thenAnswer((_) async => [fakeCharacter]);

    await viewModel.loadCharacters(reset: true);

    expect(viewModel.characters.length, 1);
    expect(viewModel.characters.first.name, 'Rick Sanchez');
    expect(viewModel.nextPage, 2);
    expect(viewModel.hasMore, isTrue);
    expect(viewModel.errorMessage, '');
    expect(viewModel.isLoading, isFalse);
  });

  test('Should stop loading characters is empty response', () async {
    when(
      () => repositoryMock.getCharacters(page: 1, search: any(named: 'search')),
    ).thenAnswer((_) async => []);

    await viewModel.loadCharacters(reset: true);

    expect(viewModel.characters.isEmpty, true);
    expect(viewModel.hasMore, isFalse);
  });

  test('Should catch error and stop loading characters', () async {
    when(
      () => repositoryMock.getCharacters(page: 1, search: any(named: 'search')),
    ).thenThrow(Exception('Unexpected error'));

    await viewModel.loadCharacters(reset: true);

    expect(viewModel.characters.isEmpty, true);
    expect(viewModel.hasMore, isFalse);
    expect(viewModel.errorMessage, contains('Unexpected error'));
  });
}
