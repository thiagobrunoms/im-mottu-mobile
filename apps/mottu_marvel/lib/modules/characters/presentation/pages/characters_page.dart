import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mottu_marvel/core/services/theme_service.dart';
import 'package:mottu_marvel/modules/characters/presentation/pages/characters_page_controller.dart';
import 'package:mottu_design_system/mottu_design_system.dart';

import '../widgets/character_item.dart';
import '../widgets/characters_list.dart';
import '../widgets/characters_page_progress_indicator.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final controller = Get.find<CharactersPageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Screen(
      scrollController: controller.scrollController,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.color_lens),
        onPressed: themeController.toggleTheme,
      ),
      appBar: MyHeaderDelegate(
        backgroundImageUrl:
            'https://www.epicstuff.com/cdn/shop/collections/MARVEL_1920x450_b691539a-a0cb-4a43-8d20-ca9d567ab290_1920x450.jpg?v=1581967770',
        bottomWidget: const _FilterCharactersTextField(),
      ),
      body: [
        Obx(
          () {
            if (controller.marvelResponse.value == null) {
              return const CharacterPageProgressIndicator();
            }

            if (controller.isError.value) {
              return const _ErrorState();
            }

            if (controller.filteredCharactersList.isEmpty) {
              if (controller.isFetching.value) {
                return const CharacterPageProgressIndicator();
              }

              return const _NoResultsFound();
            }

            return CharactersList(
              characters: controller.filteredCharactersList,
            );
          },
        ),
        const _PaginationLoading(),
        const _CleanUpSearch(),
      ],
    );
  }
}

class _FilterCharactersTextField extends StatelessWidget {
  const _FilterCharactersTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharactersPageController>();

    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: MottuTextField(
        controller: controller.searchFieldEditingController,
        hintText: "Buscar por personagens",
        prefixIcon: const Icon(
          Icons.search,
          color: MottuColors.white,
        ),
        onChanged: controller.filterCharacters,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: MottuBody1Text.bold('Algo de errado aconteceu! :('));
  }
}

class _NoResultsFound extends StatelessWidget {
  const _NoResultsFound({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharactersPageController>();

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MottuBody1Text.medium('Não há resultados locais. Deseja fazer uma busca remota?'),
          const SizedBox(height: 10.0),
          ElevatedButton(onPressed: controller.filterCharactersRemotely, child: const MottuBody1Text.bold('SIM'))
        ],
      ),
    );
  }
}

class _PaginationLoading extends StatelessWidget {
  const _PaginationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharactersPageController>();
    return Obx(
      () {
        if (controller.isFetching.value && controller.charactersList.isNotEmpty) {
          return const CharacterPageProgressIndicator();
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _CleanUpSearch extends StatelessWidget {
  const _CleanUpSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CharactersPageController>();
    return Obx(
      () {
        if (!controller.isFetching.value && controller.searchTextFieldValue.isNotEmpty) {
          return SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: controller.clearSearchField,
              child: const MottuBody1Text.bold('Limpar busca'),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
