import 'package:flutter/material.dart';
import '../../domain/category_info.dart';

const List<CategoryInfo> kCategories = [];

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
              onTap: () => Navigator.pop(context),
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
                  style: const TextStyle(
                    color: Color(0xFFD5B27A),
                    fontSize: 11,
                  ),
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