import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final List<String>? imageUrls;

  @HiveField(4)
  final int likes;

  @HiveField(5)
  final int comments;

  @HiveField(6)
  final DateTime? createdAt;

  @HiveField(7)
  final DateTime? updatedAt;

  @HiveField(8)
  final String authorName;

  @HiveField(9)
  final DateTime? timestamp;


  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrls,
    this.likes = 0,
    this.comments = 0,
    required this.createdAt,
    this.updatedAt,
    required this.authorName, 
     DateTime? timestamp,
  }): timestamp = timestamp ?? DateTime.now(); 

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      authorName: json['authorName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'imageUrls': imageUrls,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
