import '../../../../core/errors/base_error.dart';
import '../../../../core/result_wrapper/result_wrapper.dart';
import '../datasources/local/get_character_list_local_datasource.dart';
import '../datasources/remote/get_characters_associated_datasouce.dart';
import '../model/character_model.dart';

abstract class IGetCharactersAssociatedRepository {
  Future<Result<List<CharacterModel>>> getCharactersAssociated({
    required CharacterModel characterModel,
  });
}

class GetCharactersAssociatedRepository
    implements IGetCharactersAssociatedRepository {
  final IGetCharactersAssociatedDataSource remoteDataSource;
  final IGetCharactersListLocalDataSource localDataSource;

  GetCharactersAssociatedRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<CharacterModel>>> getCharactersAssociated({
    required CharacterModel characterModel,
  }) async {
    try {
      if (characterModel.charactersAssociated != null &&
          characterModel.charactersAssociated!.isNotEmpty) {
        final localCharacters = characterModel.charactersAssociated!
            .map((model) => localDataSource.getCharacterModel(model.id ?? 0))
            .whereType<CharacterModel>()
            .toList();

        if (localCharacters.isNotEmpty) {
          return ResultSuccess(localCharacters);
        }
      }

      final remoteResult = await remoteDataSource.getCharactersAssociated(
        characterModel: characterModel,
      );

      if (remoteResult is ResultSuccess) {
        final listModel = (remoteResult.getSuccessData as List)
            .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
            .toList();

        for (var character in listModel) {
          await localDataSource.addCharacter(characterModel: character);
        }

        characterModel.charactersAssociated =
            listModel.map((character) => character).toList();

        return ResultSuccess(listModel);
      } else {
        return ResultError(BaseError('${remoteResult.getErrorData}'));
      }
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
