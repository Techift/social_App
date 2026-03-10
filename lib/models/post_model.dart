class PostModel {
  final String id;
  final String content;
  final String authorName; // Changed from authorId to authorName
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.content,
    required this.authorName, // Updated parameter name
    required this.timestamp,
  });
}