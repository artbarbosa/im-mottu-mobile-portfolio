import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/helpers/connectivy_channel.dart';
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
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    getCharactersListBloc = Modular.get<IGetCharactersListBloc>();
    characterListFilterBloc = Modular.get<ICharacterListFilterBloc>();
    scrollController = ScrollController();

    _fetchCharacters();

    scrollController.addListener(_onScroll);

    ConnectivityChannel.connectionStatusStream.listen((isConnected) {
      if (!isConnected) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('You are offline'),
            actions: [
              TextButton(
                onPressed: () => Modular.to.pop(),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<void> _fetchCharacters({bool isLoadMore = false}) async {
    final params = characterListFilterBloc.createFiltersParams();
    await getCharactersListBloc.getCharactersList(
      params: params,
      isLoadMore: isLoadMore,
    );
  }

  void _onScroll() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent * 0.95 &&
        getCharactersListBloc.state is SuccessState &&
        !getCharactersListBloc.isFetching) {
      _fetchCharacters(isLoadMore: true);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
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
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              sliver: SliverToBoxAdapter(
                child: SearchTextFieldWidget(
                  characterListFilterBloc: characterListFilterBloc,
                ),
              ),
            ),
            BlocBuilder<IGetCharactersListBloc, BaseState>(
              bloc: getCharactersListBloc,
              builder: (context, state) {
                if (state is LoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is ErrorState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                List<CharacterModel> list = [];
                if (state is SuccessState) {
                  list = state.data as List<CharacterModel>;
                }
                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No data found "),
                    ),
                  );
                }
                return CharacterGridComponent(
                  characters: list,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
