import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchBooks(String query) async {
  final uri = Uri.parse(
    'https://openlibrary.org/search.json?q=${Uri.encodeQueryComponent(query)}',
  );
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return (data['docs'] as List).take(20).toList();
  } else {
    throw Exception('Server error: ${response.statusCode}');
  }
}

String? buildCoverUrl(dynamic coverId) {
  if (coverId == null) return null;
  return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
}

String buildWorkUrl(String key) {
  return 'https://openlibrary.org$key';
}