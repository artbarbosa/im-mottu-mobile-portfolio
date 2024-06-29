import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/errors/base_error.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/model/params/character_list_paramns.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_character_list_repository.dart';

import '../../mock/character_mock.dart';

void main() {
  late GetCharactersListRepository repository;
  late MockGetCharactersListDataSource mockRemoteDataSource;
  late MockGetCharactersListLocalDataSource mockLocalDataSource;

  setUp(() {
    registerFallbackValue(CharacterListParams());
    registerFallbackValue(CharacterModel());
  });

  setUp(() {
    mockRemoteDataSource = MockGetCharactersListDataSource();
    mockLocalDataSource = MockGetCharactersListLocalDataSource();
    repository = GetCharactersListRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('GetCharactersListRepository', () {
    test('Fetch from Remote Success', () async {
      final params =
          CharacterListParams(nameStartsWith: 'Iron', orderBy: 'name');
      final remoteCharacters = [
        {'id': 1, 'name': 'Iron Man'},
        {'id': 2, 'name': 'Iron Fist'},
      ];

      final remoteResult = ResultSuccess(remoteCharacters);

      when(() => mockRemoteDataSource.getCharactersList(params: params))
          .thenAnswer((_) => Future.value(remoteResult));

      final result = await repository.getCharactersList(params: params);

      expect(result.getSuccessData.first.id, 1);
    });

    test('Fetch from Local', () async {
      final params = CharacterListParams(
        nameStartsWith: null,
        orderBy: 'name',
      );
      final localCharacters = [
        CharacterModel(id: 3, name: 'Thor'),
      ];

      when(() => mockLocalDataSource.getAllCharacter(params: params))
          .thenReturn(localCharacters);

      final result = await repository.getCharactersList(params: params);

      expect(result, isA<ResultSuccess<List<CharacterModel>>>());

      verifyNever(
        () => mockRemoteDataSource.getCharactersList(
          params: any(named: 'params'),
        ),
      );
    });

    test('Fetch from Remote Error', () async {
      final params =
          CharacterListParams(nameStartsWith: 'Invalid', orderBy: 'name');
      const error = 'Failed to fetch data';
      final remoteResult = ResultError(BaseError(error));

      when(() => mockRemoteDataSource.getCharactersList(params: params))
          .thenAnswer((_) => Future.value(remoteResult));

      final result = await repository.getCharactersList(params: params);

      expect(result, isA<ResultError<List<CharacterModel>>>());
    });

    test('Error Handling', () async {
      final params =
          CharacterListParams(nameStartsWith: 'Error', orderBy: 'name');
      final exception = Exception('Error occurred');

      when(() => mockRemoteDataSource.getCharactersList(params: params))
          .thenThrow(exception);

      final result = await repository.getCharactersList(params: params);

      expect(result, isA<ResultError<List<CharacterModel>>>());
    });
  });
}
