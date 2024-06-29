import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../bloc/get_characters_list_bloc.dart';

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
      body: BlocBuilder(
        bloc: getCharactersListBloc,
        builder: (context, state) {
          if (state is SuccessState) {
            final list = state.data as List<CharacterModel>;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Text(list[index].name ?? "");
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
