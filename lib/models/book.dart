class Book {
  final String title;
  final List<String> authors;
  final int? firstPublishYear;
  final String? coverId;
  final String? workKey;

  Book({
    required this.title,
    required this.authors,
    this.firstPublishYear,
    this.coverId,
    this.workKey,
  });

  String? get coverImageUrl {
    if (coverId == null) return null;
    return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
  }

  String? get openLibraryUrl {
    if (workKey == null) return null;
    return 'https://openlibrary.org$workKey';
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String? ?? 'Unknown title',
      authors: (json['author_name'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      firstPublishYear: json['first_publish_year'] as int?,
      coverId: json['cover_i']?.toString(),
      workKey: json['key'] as String?,
    );
  }
}