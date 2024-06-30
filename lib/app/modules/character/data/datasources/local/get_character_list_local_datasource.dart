import 'package:hive/hive.dart';

import '../../model/character_model.dart';
import '../../model/params/character_list_paramns.dart';

abstract class IGetCharactersListLocalDataSource {
  CharacterModel? getCharacterModel(int id);
  Future<void> addCharacter({required CharacterModel characterModel});
  List<CharacterModel> getAllCharacter({
    required CharacterListParams params,
  });
}

class GetCharactersListLocalDataSource
    implements IGetCharactersListLocalDataSource {
  final characterBox = Hive.box<CharacterModel>('characterBox');

  static Future<void> init() async {
    await Hive.openBox<CharacterModel>('characterBox');
  }

  @override
  Future<void> addCharacter({required CharacterModel characterModel}) async {
    await characterBox.put(characterModel.id, characterModel);
  }

  @override
  CharacterModel? getCharacterModel(int id) => characterBox.get(id);

  @override
  List<CharacterModel> getAllCharacter({
    required CharacterListParams params,
  }) {
    var filteredCharacters = params.nameStartsWith != null
        ? characterBox.values
            .where(
              (character) => character.name!.toLowerCase().contains(
                    params.nameStartsWith!.toLowerCase(),
                  ),
            )
            .toList()
        : characterBox.values.toList();

    filteredCharacters.sort((a, b) => a.name!.compareTo(b.name!));

    if (params.orderBy == 'modified') {
      filteredCharacters.sort((a, b) => a.modified!.compareTo(b.modified!));
    }

    if (params.orderBy!.contains('-')) {
      filteredCharacters = filteredCharacters.reversed.toList();
    }

    return filteredCharacters;
  }
}
