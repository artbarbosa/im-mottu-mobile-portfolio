import 'package:hive/hive.dart';

import '../../model/character_model.dart';

abstract class IGetCharactersListLocalDataSource {
  CharacterModel? getCharacterModel(String sku);
  Future<void> addCharacter({required CharacterModel characterModel});
  List<CharacterModel> getAllCharacter();
}

class GetCharactersListLocalDataSource
    implements IGetCharactersListLocalDataSource {
  final characterBox = Hive.box<CharacterModel>('characterBox');

  static Future<void> init() async {
    await Hive.openBox<CharacterModel>('characterBox');
  }

  @override
  Future<void> addCharacter({required CharacterModel characterModel}) async {
    for (var existingCharacter in characterBox.values) {
      if (existingCharacter.id == characterModel.id) {
        return;
      }
    }
    await characterBox.add(characterModel);
  }

  @override
  CharacterModel? getCharacterModel(String id) => characterBox.get(id);

  @override
  List<CharacterModel> getAllCharacter() => characterBox.values.toList();
}
