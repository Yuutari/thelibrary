import 'package:flutter/material.dart';
import '../../data/characters_repository.dart';
import '../../data/open_library_service.dart';
import '../../models/pm_character.dart';
import '../widgets/character_card.dart';
import 'character_details_screen.dart';

class CharactersListScreen extends StatelessWidget {
  final CharactersRepository repository;
  final OpenLibraryService openLibraryService;

  const CharactersListScreen({
    super.key,
    required this.repository,
    required this.openLibraryService,
  });

  @override
  Widget build(BuildContext context) {
    final List<PmCharacter> characters = repository.getAll();

    if (characters.isEmpty) {
      return const Center(
        child: Text('Список грешников пуст.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final c = characters[index];
        return CharacterCard(
          character: c,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CharacterDetailsScreen(
                  character: c,
                  openLibraryService: openLibraryService,
                ),
              ),
            );
          },
        );
      },
    );
  }
}