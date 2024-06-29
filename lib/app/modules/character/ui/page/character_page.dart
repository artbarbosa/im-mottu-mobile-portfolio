import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../bloc/character_list_filter_bloc.dart';
import '../bloc/get_characters_list_bloc.dart';
import 'component/character_grid_component.dart';

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

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Order By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                value: characterListFilterBloc.orderBy,
                items: const [
                  DropdownMenuItem(
                    value: 'name',
                    child: Text('Name (Ascending)'),
                  ),
                  DropdownMenuItem(
                    value: '-name',
                    child: Text('Name (Descending)'),
                  ),
                  DropdownMenuItem(
                    value: 'modified',
                    child: Text('Modified (Ascending)'),
                  ),
                  DropdownMenuItem(
                    value: '-modified',
                    child: Text('Modified (Descending)'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    characterListFilterBloc.updateOrderByFilter(value: value);
                    characterListFilterBloc.applyFilters();
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     characterListFilterBloc.applyFilters();
              //     Navigator.pop(context);
              //   },
              //   child: const Text('Apply Filters'),
              // ),
            ],
          ),
        );
      },
    );
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
              onPressed: _showFilterOptions,
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
                child: TextField(
                  onChanged: (value) {
                    if (value.isEmpty &&
                        characterListFilterBloc.nameStartsWith != null) {
                      characterListFilterBloc.updateNameStartWithFilter(
                        value: null,
                      );
                      characterListFilterBloc.applyFilters();
                    }
                  },
                  onSubmitted: (value) {
                    characterListFilterBloc.updateNameStartWithFilter(
                      value: value,
                    );
                    characterListFilterBloc.applyFilters();
                  },
                  decoration: InputDecoration(
                    hintText: "Search characters",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
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
