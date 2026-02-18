import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class OpenLibraryService {
  static const _baseUrl = 'https://openlibrary.org';

  Future<List<Book>> searchBooks({
    String? title,
    String? author,
  }) async {
    final params = <String, String>{};
    if (title != null && title.isNotEmpty) params['title'] = title;
    if (author != null && author.isNotEmpty) params['author'] = author;
    params['limit'] = '10';

    final uri = Uri.parse('$_baseUrl/search.json')
        .replace(queryParameters: params);

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('OpenLibrary error: ${response.statusCode}');
    }

    final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
    final docs = jsonMap['docs'] as List<dynamic>? ?? [];
    return docs.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
  }
}