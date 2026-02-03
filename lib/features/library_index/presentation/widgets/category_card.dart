import 'package:flutter/material.dart';
import '../../domain/category_info.dart';

class CategoryCard extends StatelessWidget {
  final CategoryInfo category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
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
                color: category.color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF4E1B2),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.subtitle,
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
                  '${category.articles} articles',
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