import 'package:flutter/material.dart';
import '../../models/pm_character.dart';
import '../../models/book.dart';
import '../../data/open_library_service.dart';
import '../widgets/book_list_tile.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final PmCharacter character;
  final OpenLibraryService openLibraryService;

  const CharacterDetailsScreen({
    super.key,
    required this.character,
    required this.openLibraryService,
  });

  @override
  State<CharacterDetailsScreen> createState() =>
      _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _loadBooks();
  }

  Future<List<Book>> _loadBooks() {
    final title = widget.character.originWork.split(',').first.trim();
    final author = widget.character.author;
    return widget.openLibraryService.searchBooks(
      title: title,
      author: author,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    return Scaffold(
      appBar: AppBar(
        title: Text('${c.sinnerNumber}. ${c.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: c.tags
                  .map((t) => Chip(label: Text(t)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              c.shortLore,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(c.detailedLore),
            const SizedBox(height: 24),
            Text(
              'Литературный источник',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${c.originWork} — ${c.author}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            Text(
              'Книги из OpenLibrary',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Book>>(
              future: _booksFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Ошибка загрузки: ${snapshot.error}');
                }
                final books = snapshot.data ?? [];
                if (books.isEmpty) {
                  return const Text(
                    'Книги по этим параметрам не найдены.',
                  );
                }
                return Column(
                  children: books
                      .map((b) => BookListTile(book: b))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}