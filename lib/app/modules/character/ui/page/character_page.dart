import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mottu_marvel/app/core/helpers/image_helper.dart';
import 'package:shimmer/shimmer.dart';

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
      appBar: AppBar(
        title: const Text(
          'Marvel Characters',
        ),
      ),
      body: BlocBuilder<IGetCharactersListBloc, BaseState>(
        bloc: getCharactersListBloc,
        builder: (context, state) {
          if (state is SuccessState) {
            final list = state.data as List<CharacterModel>;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final model = list[index];
                final imageUrl = ImageHelper.formatImagePath(
                  model.thumbnail?.path ?? "",
                  model.thumbnail?.extension ?? "",
                );
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5.0,
                  child: InkWell(
                    onTap: () {
                      Modular.to.pushNamed(
                        "/detail",
                        arguments: model,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            model.name ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
