import 'package:flutter/widgets.dart';

import '../../../data/model/character_model.dart';
import '../widgets/character_card_widget.dart';

class CharacterGridComponent extends StatelessWidget {
  final List<CharacterModel> characters;

  const CharacterGridComponent({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) => CharacterCardWidget(
        model: characters[index],
      ),
    );
  }
}
