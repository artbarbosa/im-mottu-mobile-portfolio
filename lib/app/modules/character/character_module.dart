import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'data/datasources/local/get_character_list_local_datasource.dart';
import 'data/datasources/remote/get_character_list_datasource.dart';
import 'data/repositories/get_character_list_repository.dart';
import 'ui/bloc/character_list_filter_bloc.dart';
import 'ui/bloc/get_characters_list_bloc.dart';
import 'ui/page/character_detail_page.dart';
import 'ui/page/character_page.dart';

class CharacterModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton<IGetCharactersListDataSource>(
        GetCharactersListDataSource.new);
    i.addSingleton<IGetCharactersListLocalDataSource>(
        GetCharactersListLocalDataSource.new);

    i.addSingleton<IGetCharactersListRepository>(
        GetCharactersListRepository.new);

    i.addSingleton<IGetCharactersListBloc>(GetCharactersListBloc.new);
    i.addSingleton<ICharacterListFilterBloc>(CharacterListFilterBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const CharacterPage());
    r.child('/detail',
        child: (context) => CharacterDetailPage(
              model: r.args.data,
            ));
  }
}
