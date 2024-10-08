import 'package:flutter/material.dart';
import 'package:mottu_design_system/mottu_design_system.dart';

import '../../data/models/marvel_response_model.dart';
import '../router/character_router.dart';

class MarvelCharacterItem extends StatelessWidget {
  const MarvelCharacterItem({super.key, required this.marvelCharacter});

  final MarvelCharacter marvelCharacter;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CharacterRouter.goToCharacterDetails(marvelCharacter),
      child: Row(
        children: [
          MottuNetworkImage(
            url: marvelCharacter.imageUrl,
          ),
          const SizedBox(width: 20),
          MottuHeading1Text.regular(marvelCharacter.name)
        ],
      ),
    );
  }
}
