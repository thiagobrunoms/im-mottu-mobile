import 'package:flutter/material.dart';

import '../../data/models/marvel_response_model.dart';
import 'character_item.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key, required this.characters});

  final List<MarvelCharacter> characters;

  @override
  Widget build(BuildContext context) {
    final List<Widget> charactersList = characters
        .map((eachCharacter) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: MarvelCharacterItem(
                marvelCharacter: eachCharacter,
              ),
            ))
        .toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => charactersList[index],
        childCount: charactersList.length,
      ),
    );
  }
}
