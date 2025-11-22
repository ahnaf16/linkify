class Bookmark {
  Bookmark({
    required this.id,
    required this.url,
    this.title,
    this.description,
    this.tag,
    this.isSynced = false,
    this.isPinned = false,
    required this.createdAt,
  });

  final String id;
  final String url;
  final String? title;
  final String? description;
  final String? tag;
  final bool isSynced;
  final bool isPinned;
  final DateTime createdAt;
}
