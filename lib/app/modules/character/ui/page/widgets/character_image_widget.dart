import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/image_helper.dart';
import '../../../data/model/character_model.dart';

class CharacterImageWidget extends StatelessWidget {
  const CharacterImageWidget({super.key, required this.model});

  final CharacterModel model;

  @override
  Widget build(BuildContext context) {
    final imageUrl = ImageHelper.formatImagePath(
      model.thumbnail?.path ?? "",
      model.thumbnail?.extension ?? "",
    );

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Container(
        height: 300,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 300,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(
            Icons.error,
            size: 50,
          ),
        ),
      ),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 300,
    );
  }
}
