import 'package:flutter/material.dart';
import '../domain/category_info.dart';
import '../navigation/presentation/library_drawer.dart';
import 'widgets/search_bar.dart';
import 'widgets/category_card.dart';

const List<CategoryInfo> kCategories = [];

class CategoryPage extends StatelessWidget {
  final CategoryInfo category;
  const CategoryPage({required this.category});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(category.title)),
    body: Center(child: Text(category.subtitle)),
  );
}

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
      setState(() => _query = _searchController.text);
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
    final matched = _findFirstMatch(_query);

    return Scaffold(
      drawer: LibraryDrawer(onSelectCategory: _openCategory),
      appBar: AppBar(
        toolbarHeight: 72,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFF4E1B2)),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
            SearchBarWidget(
              controller: _searchController,
              onSubmitted: (value) {
                final category = _findFirstMatch(value);
                if (category != null) _openCategory(category);
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
                      (c) => CategoryCard(
                        category: c,
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