import '../../../../core/result_wrapper/result_wrapper.dart';
import '../datasources/get_character_list_datasource.dart';
import '../model/character_model.dart';
import 'mock_character.dart';

abstract class IGetCharactersListRepository {
  Future<Result<List<CharacterModel>>> getCharactersList();
}

class GetCharactersListRepository implements IGetCharactersListRepository {
  final IGetCharactersListDataSource datasource;

  GetCharactersListRepository({
    required this.datasource,
  });

  @override
  Future<Result<List<CharacterModel>>> getCharactersList() async {
    // final result = await datasource.getCharactersList();
    final result = ResultSuccess(characterListMock);
    // if (result is ResultSuccess) {
    final listModel = (result.getSuccessData["data"]["results"] as List)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return ResultSuccess(listModel);
    // } else {
    //   return ResultError(BaseError('${result.getErrorData}'));
    // }
  }
}
