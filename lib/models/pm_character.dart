class PmCharacter {
  final String id;
  final String name;
  final String sinnerNumber;
  final String originWork;
  final String author;
  final String shortLore;
  final String detailedLore;
  final List<String> tags;

  const PmCharacter({
    required this.id,
    required this.name,
    required this.sinnerNumber,
    required this.originWork,
    required this.author,
    required this.shortLore,
    required this.detailedLore,
    required this.tags,
  });
}