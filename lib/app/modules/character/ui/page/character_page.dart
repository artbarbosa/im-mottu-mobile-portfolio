import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../bloc/character_list_filter_bloc.dart';
import '../bloc/get_characters_list_bloc.dart';
import 'component/character_grid_component.dart';
import 'widgets/filter_options_modal.dart';
import 'widgets/search_textfield_widget.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late IGetCharactersListBloc getCharactersListBloc;
  late ICharacterListFilterBloc characterListFilterBloc;

  @override
  void initState() {
    super.initState();
    getCharactersListBloc = Modular.get<IGetCharactersListBloc>();
    characterListFilterBloc = Modular.get<ICharacterListFilterBloc>();

    final params = characterListFilterBloc.createFiltersParams();
    getCharactersListBloc.getCharactersList(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel Characters'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => FilterOptionsModal(
                  characterListFilterBloc: characterListFilterBloc,
                ),
              ),
              icon: const Icon(Icons.filter_list),
              label: const Text('Filters'),
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ICharacterListFilterBloc, BaseState>(
            bloc: characterListFilterBloc,
            listener: (context, state) {
              if (state is ChangeState) {
                final params = characterListFilterBloc.createFiltersParams();
                getCharactersListBloc.getCharactersList(params: params);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: SearchTextFieldWidget(
                  characterListFilterBloc: characterListFilterBloc,
                ),
              ),
              BlocBuilder<IGetCharactersListBloc, BaseState>(
                bloc: getCharactersListBloc,
                builder: (context, state) {
                  if (state is SuccessState) {
                    final list = state.data as List<CharacterModel>;
                    return CharacterGridComponent(
                      characters: list,
                    );
                  } else if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
