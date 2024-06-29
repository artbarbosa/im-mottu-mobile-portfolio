import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'data/datasources/get_character_list_datasource.dart';
import 'data/repositories/get_character_list_repository.dart';

class CharacterModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<IGetCharactersListDataSource>(
        GetCharactersListDataSource.new);
    i.addSingleton<IGetCharactersListRepository>(
        GetCharactersListRepository.new);
  }

  @override
  void routes(r) {}
}
