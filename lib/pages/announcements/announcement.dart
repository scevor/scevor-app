class Announcement {
  final int id;
  final DateTime createdAt;
  final String author;
  final String title;
  final String text;
  final bool important;

  Announcement({
    required this.id,
    required this.createdAt,
    required this.author,
    required this.title,
    required this.text,
    required this.important
  });

  Announcement.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        createdAt = DateTime.parse(map['created_at']),
        author = map['author'],
        title = map['title'],
        text = map['content'],
        important = map['important'];
}