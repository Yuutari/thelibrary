import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP [web:41]
import 'package:url_launcher/url_launcher.dart'; // открытие ссылок [web:69]

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Index',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFF20120B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3A2415),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const LibraryIndexPage(),
    );
  }
}

class CategoryInfo {
  final String id;
  final String title;
  final String subtitle;
  final int articles;
  final Color color;
  final String searchQuery; // запрос в Open Library
  final String description; // текст для экрана категории

  const CategoryInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.articles,
    required this.color,
    required this.searchQuery,
    required this.description,
  });
}

/// Тематические разделы с лором/описанием и поисковыми запросами
const List<CategoryInfo> kCategories = [
  CategoryInfo(
    id: 'getting-started',
    title: 'GETTING STARTED',
    subtitle: 'Introduction, basics, and tutorials',
    articles: 3,
    color: Color(0xFFF2C94C),
    searchQuery: 'learning how to read',
    description:
        'Вводный этаж библиотеки. Здесь собраны книги и руководства, помогающие быстро войти в новую тему, освоить базовые понятия и выстроить фундамент знаний.',
  ),
  CategoryInfo(
    id: 'combat',
    title: 'COMBAT',
    subtitle: 'Battle mechanics and strategies',
    articles: 3,
    color: Color(0xFFE57373),
    searchQuery: 'strategy tactics warfare',
    description:
        'Раздел о стратегическом мышлении и принятии решений. Тактика, военное дело, управление ресурсами и любые книги, учящие “сражаться” за результат.',
  ),
  CategoryInfo(
    id: 'characters',
    title: 'CHARACTERS',
    subtitle: 'Librarians, Guests, and more',
    articles: 3,
    color: Color(0xFF9B51E0),
    searchQuery: 'biography famous people',
    description:
        'Этаж персон. Биографии учёных, писателей, исторических фигур и вымышленных героев, через которых раскрываются эпохи и идеи.',
  ),
  CategoryInfo(
    id: 'lore-world',
    title: 'LORE & WORLD',
    subtitle: 'The City, Wings, and history',
    articles: 3,
    color: Color(0xFF4DB6AC),
    searchQuery: 'worldbuilding history mythology',
    description:
        'Мироустройство и лор. Книги об истории, мифах, культурах и создании вымышленных миров — от реальных цивилизаций до фэнтези‑сеттингов.',
  ),
  CategoryInfo(
    id: 'library-floors',
    title: 'LIBRARY FLOORS',
    subtitle: 'All floors and departments',
    articles: 5,
    color: Color(0xFFF2C94C),
    searchQuery: 'architecture library design',
    description:
        'Структура самой библиотеки. Архитектура знаний, устройство библиотек, организация пространства и информации.',
  ),
  CategoryInfo(
    id: 'abnormalities',
    title: 'ABNORMALITIES',
    subtitle: 'Special entities and powers',
    articles: 4,
    color: Color(0xFFFFA726),
    searchQuery: 'occult forbidden books mysteries',
    description:
        'Странные и “аномальные” тексты: спорные, мистические, маргинальные работы и книги с необычной репутацией.',
  ),
];

class LibraryIndexPage extends StatefulWidget {
  const LibraryIndexPage({super.key});

  @override
  State<LibraryIndexPage> createState() => _LibraryIndexPageState();
}

class _LibraryIndexPageState extends State<LibraryIndexPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCategory(CategoryInfo category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(category: category),
      ),
    );
  }

  CategoryInfo? _findFirstMatch(String query) {
    if (query.trim().isEmpty) return null;
    final lower = query.toLowerCase();
    try {
      return kCategories.firstWhere(
        (c) =>
            c.title.toLowerCase().contains(lower) ||
            c.subtitle.toLowerCase().contains(lower),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CategoryInfo? matched = _findFirstMatch(_query);

    return Scaffold(
      drawer: LibraryDrawer(onSelectCategory: _openCategory),
      appBar: AppBar(
        toolbarHeight: 72,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFF4E1B2)),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: 'Open navigation',
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'LIBRARY INDEX',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4E1B2),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Knowledge Repository',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFD5B27A),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            _SearchBar(
              controller: _searchController,
              onSubmitted: (value) {
                final category = _findFirstMatch(value);
                if (category != null) {
                  _openCategory(category);
                }
              },
            ),
            if (matched != null && _query.isNotEmpty)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'First match: ${matched.title}',
                  style: const TextStyle(
                    color: Color(0xFFF2C94C),
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: kCategories
                    .map(
                      (c) => _CategoryCard(
                        title: c.title,
                        subtitle: c.subtitle,
                        articles: c.articles,
                        color: c.color,
                        onTap: () => _openCategory(c),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  const _SearchBar({
    // super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF2B1810),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8D6E63), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFFD5B27A)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Color(0xFFF4E1B2),
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(
                  color: Color(0xFFB68E64),
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int articles;
  final Color color;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.articles,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2B1810),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF8D6E63), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4E1B2),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFD5B27A),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Text(
                  '• ',
                  style: TextStyle(color: Color(0xFFF2C94C)),
                ),
                Text(
                  '$articles articles',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF2C94C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Drawer с темами
class LibraryDrawer extends StatelessWidget {
  final void Function(CategoryInfo category) onSelectCategory;

  const LibraryDrawer({super.key, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF2B1810),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Navigation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF4E1B2),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFD5B27A)),
              title: const Text(
                'Library index',
                style: TextStyle(color: Color(0xFFF4E1B2)),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Color(0xFF8D6E63)),
            ...kCategories.map(
              (c) => ListTile(
                leading: const Icon(Icons.menu_book, color: Color(0xFFD5B27A)),
                title: Text(
                  c.title,
                  style: const TextStyle(color: Color(0xFFF4E1B2)),
                ),
                subtitle: Text(
                  c.subtitle,
                  style: const TextStyle(color: Color(0xFFD5B27A), fontSize: 11),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onSelectCategory(c);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// API
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

// Covers API
String? buildCoverUrl(dynamic coverId) {
  if (coverId == null) return null;
  return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
}

// Страница книги в Open Library
String buildWorkUrl(String key) {
  // key
  return 'https://openlibrary.org$key';
}

class CategoryPage extends StatefulWidget {
  final CategoryInfo category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool loading = true;
  String? error;
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final result = await fetchBooks(widget.category.searchQuery);
      setState(() {
        items = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load: $e';
        loading = false;
      });
    }
  }

  void _openBook(Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailsPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.category.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF4E1B2),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF4E1B2)),
      ),
      backgroundColor: const Color(0xFF20120B),
      body: Column(
        children: [
          // блок описания категории
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: const BoxDecoration(
              color: Color(0xFF2B1810),
              border: Border(
                bottom: BorderSide(color: Color(0xFF3A2415), width: 1),
              ),
            ),
            child: Text(
              widget.category.description,
              style: const TextStyle(
                color: Color(0xFFD5B27A),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFF2C94C)),
                  )
                : error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              error!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _loadData,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(
                          color: Color(0xFF3A2415),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final book = items[index] as Map<String, dynamic>;
                          final title =
                              (book['title'] as String?) ?? 'Unknown title';
                          final authors =
                              (book['author_name'] as List?)?.join(', ') ??
                                  'Unknown author';
                          final year =
                              (book['first_publish_year']?.toString()) ??
                                  'Year?';
                          final coverUrl = buildCoverUrl(book['cover_i']);

                          return ListTile(
                            onTap: () => _openBook(book),
                            leading: coverUrl != null
                                ? Image.network(
                                    coverUrl,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.menu_book,
                                    color: Color(0xFFD5B27A)),
                            title: Text(
                              title,
                              style: const TextStyle(
                                color: Color(0xFFF4E1B2),
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '$authors • $year',
                              style: const TextStyle(
                                color: Color(0xFFD5B27A),
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Color(0xFFD5B27A),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

/// Детальный экран книги с кнопкой открытия страницы Open Library
class BookDetailsPage extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailsPage({super.key, required this.book});

  Future<void> _launchOpenLibraryPage() async {
    final key = (book['key'] as String?) ?? '';
    if (key.isEmpty) return;
    final url = Uri.parse(buildWorkUrl(key));
    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          mode: LaunchMode.externalApplication); // открытие в браузере [web:50]
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = (book['title'] as String?) ?? 'Unknown title';
    final authors =
        (book['author_name'] as List?)?.join(', ') ?? 'Unknown author';
    final year = (book['first_publish_year']?.toString()) ?? 'Year?';
    final description =
        (book['subtitle'] as String?) ?? 'Описание для этой книги ещё не добавлено.';
    final coverUrl = buildCoverUrl(book['cover_i']);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF4E1B2),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF4E1B2)),
      ),
      backgroundColor: const Color(0xFF20120B),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (coverUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    coverUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFF4E1B2),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              authors,
              style: const TextStyle(
                color: Color(0xFFD5B27A),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'First published: $year',
              style: const TextStyle(
                color: Color(0xFFD5B27A),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                color: Color(0xFFD5B27A),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2C94C),
                  foregroundColor: const Color(0xFF3A2415),
                ),
                onPressed: _launchOpenLibraryPage,
                label: const Text('Открыть в Open Library'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}