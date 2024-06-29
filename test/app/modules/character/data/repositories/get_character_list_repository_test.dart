import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/errors/base_error.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_character_list_repository.dart';

import '../../mock/character_mock.dart';

void main() {
  late GetCharactersListRepository repository;
  late MockGetCharactersListDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockGetCharactersListDataSource();
    repository = GetCharactersListRepository(datasource: mockDataSource);
  });

  group('getCharactersList', () {
    test(
        'should return a list of CharacterModel when the request is successful',
        () async {
      when(() => mockDataSource.getCharactersList()).thenAnswer(
          (_) async => ResultSuccess(characterListMock["data"]["results"]));

      final result = await repository.getCharactersList();

      expect(result, isA<Result<List<CharacterModel>>>());
    });

    test('should return an error result when the request fails', () async {
      final mockError = BaseError('Request failed');
      when(() => mockDataSource.getCharactersList())
          .thenAnswer((_) async => ResultError(mockError));

      final result = await repository.getCharactersList();

      expect(result, isA<Result<List<CharacterModel>>>());
    });
  });
}
