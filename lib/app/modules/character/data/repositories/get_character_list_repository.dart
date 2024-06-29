import '../../../../core/errors/base_error.dart';
import '../../../../core/result_wrapper/result_wrapper.dart';
import '../datasources/local/get_character_list_local_datasource.dart';
import '../datasources/remote/get_character_list_datasource.dart';
import '../model/character_model.dart';
import '../model/params/character_list_paramns.dart';

abstract class IGetCharactersListRepository {
  Future<Result<List<CharacterModel>>> getCharactersList({
    required CharacterListParams params,
  });
}

class GetCharactersListRepository implements IGetCharactersListRepository {
  final IGetCharactersListDataSource remoteDataSource;
  final IGetCharactersListLocalDataSource localDataSource;

  GetCharactersListRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<List<CharacterModel>>> getCharactersList({
    required CharacterListParams params,
  }) async {
    try {
      final localCharacters = localDataSource.getAllCharacter();
      if (localCharacters.isNotEmpty) {
        return ResultSuccess(localCharacters);
      }

      final remoteResult = await remoteDataSource.getCharactersList(
        params: params,
      );

      if (remoteResult is ResultSuccess) {
        final listModel = (remoteResult.getSuccessData as List)
            .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
            .toList();
        for (var character in listModel) {
          await localDataSource.addCharacter(characterModel: character);
        }
        return ResultSuccess(listModel);
      } else {
        return ResultError(BaseError('${remoteResult.getErrorData}'));
      }
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
