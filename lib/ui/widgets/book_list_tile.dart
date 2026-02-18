import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/book.dart';

class BookListTile extends StatelessWidget {
  final Book book;

  const BookListTile({super.key, required this.book});

  Future<void> _openBook() async {
    final url = book.openLibraryUrl;
    if (url == null) return;
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _openBook,
      leading: book.coverImageUrl != null
          ? Image.network(
              book.coverImageUrl!,
              width: 40,
              fit: BoxFit.cover,
            )
          : const Icon(Icons.book),
      title: Text(book.title),
      subtitle: Text(
        [
          if (book.authors.isNotEmpty) book.authors.join(', '),
          if (book.firstPublishYear != null)
            'Год: ${book.firstPublishYear}',
        ].where((e) => e.isNotEmpty).join(' • '),
      ),
      trailing: const Icon(Icons.open_in_new),
    );
  }
}