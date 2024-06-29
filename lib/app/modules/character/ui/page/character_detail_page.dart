import 'package:flutter/material.dart';

import '../../data/model/character_model.dart';
import 'widgets/character_image_widget.dart';
import 'widgets/character_info_widget.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({super.key, required this.model});
  final CharacterModel model;

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
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
          ],
        ),
      ),
    );
  }
}
