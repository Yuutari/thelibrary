import 'package:flutter/material.dart';

class CategoryInfo {
  final String id;
  final String title;
  final String subtitle;
  final int articles;
  final Color color;
  final String searchQuery;
  final String description;

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
        'Раздел о стратегическом мышлении и принятии решений. Тактика, военное дело, управление ресурсами и любые книги, учащие “сражаться” за результат.',
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