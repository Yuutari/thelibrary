import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  const SearchBarWidget({
    super.key,
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