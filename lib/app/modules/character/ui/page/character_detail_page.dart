import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../bloc/get_characters_associated_bloc.dart';
import 'component/character_grid_component.dart';
import 'widgets/character_image_widget.dart';
import 'widgets/character_info_widget.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key, required this.model});
  final CharacterModel model;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  late IGetCharactersAssociatedBloc getCharactersAssociatedBloc;

  @override
  void initState() {
    super.initState();
    getCharactersAssociatedBloc = Modular.get<IGetCharactersAssociatedBloc>();
    getCharactersAssociatedBloc.getCharactersAssociated(
      characterModel: widget.model,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model.name ?? 'Character Details',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CharacterImageWidget(model: widget.model),
            CharacterInfoWidget(model: widget.model),
            BlocBuilder<IGetCharactersAssociatedBloc, BaseState>(
              bloc: getCharactersAssociatedBloc,
              builder: (context, state) {
                if (state is SuccessState) {
                  final characters = state.data as List<CharacterModel>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Relacionados:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CharacterGridComponent(
                        characters: characters,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
