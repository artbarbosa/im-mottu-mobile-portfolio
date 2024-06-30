import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_characters_associated_repository.dart';

import '../../mock/character_mock.dart';

void main() {
  late IGetCharactersAssociatedRepository repository;
  late MockGetCharactersAssociatedDataSource mockRemoteDataSource;
  late MockGetCharactersListLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(CharacterModel());
  });

  setUp(() {
    mockRemoteDataSource = MockGetCharactersAssociatedDataSource();
    mockLocalDataSource = MockGetCharactersListLocalDataSource();
    repository = GetCharactersAssociatedRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  test(
    'getCharactersAssociated returns ResultSuccess with local characters when available',
    () async {
      when(() => mockLocalDataSource.getCharacterModel(any()))
          .thenReturn(CharacterModel());

      final result = await repository.getCharactersAssociated(
        characterModel: CharacterModel(charactersAssociated: [
          CharacterModel(),
        ]),
      );

      // Assertions
      expect(result, isA<ResultSuccess>());
      expect((result as ResultSuccess).getSuccessData,
          isA<List<CharacterModel>>());
      verify(() => mockLocalDataSource.getCharacterModel(any())).called(1);
    },
  );

  test(
    'getCharactersAssociated returns ResultSuccess on successful remote fetch',
    () async {
      final remoteCharacters = [
        {'id': 1, 'name': 'Iron Man'},
        {'id': 2, 'name': 'Iron Fist'},
      ];
      final remoteResult = ResultSuccess(remoteCharacters);

      when(() => mockRemoteDataSource.getCharactersAssociated(
              characterModel: any(named: "characterModel")))
          .thenAnswer((_) async => remoteResult);

      final result = await repository.getCharactersAssociated(
        characterModel: CharacterModel(),
      );

      expect(result, isA<ResultSuccess>());
      expect((result as ResultSuccess).getSuccessData,
          isA<List<CharacterModel>>());
    },
  );
}
