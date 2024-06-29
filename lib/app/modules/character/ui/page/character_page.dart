import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../bloc/get_characters_list_bloc.dart';
import 'component/character_grid_component.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late IGetCharactersListBloc getCharactersListBloc;

  @override
  void initState() {
    super.initState();
    getCharactersListBloc = Modular.get<IGetCharactersListBloc>();
    getCharactersListBloc.getCharactersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel Characters'),
      ),
      body: BlocBuilder<IGetCharactersListBloc, BaseState>(
        bloc: getCharactersListBloc,
        builder: (context, state) {
          if (state is SuccessState) {
            final list = state.data as List<CharacterModel>;
            return CharacterGridComponent(characters: list);
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
