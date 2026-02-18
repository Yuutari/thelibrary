import 'package:flutter/material.dart';
import '../../models/pm_character.dart';

class CharacterCard extends StatelessWidget {
  final PmCharacter character;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(character.sinnerNumber),
        ),
        title: Text(character.name),
        subtitle: Text('${character.originWork} • ${character.author}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}