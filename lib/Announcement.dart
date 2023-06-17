class Announcement {
  final String title;
  final String text;
  final int id;
  final DateTime createdAt;
  final String author;
  final bool important;

  Announcement({
    required this.id,
    required this.createdAt,
    required this.author,
    required this.title,
    required this.text,
    required this.important
  });
}