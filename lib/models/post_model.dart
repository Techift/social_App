import 'package:hive/hive.dart';
import 'package:social_app/models/comment_model.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel extends HiveObject{
  @HiveField(0)
   String id;

  @HiveField(1)
   String userId;

  @HiveField(2)
   String content;

  @HiveField(3)
   List<String>? imageUrls;

  @HiveField(4)
   List<String> likes;

  @HiveField(5)
   List <CommentModel> comments;

  @HiveField(6)
   DateTime? createdAt;

  @HiveField(7)
   DateTime? updatedAt;

  @HiveField(8)
   String authorName;

  @HiveField(9)
   DateTime? timestamp;


  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrls,
    this.likes = const [],
    this.comments = const [],
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
    imageUrls: List<String>.from(json['imageUrls'] ?? []),
    likes: List<String>.from(json['likes'] ?? []),
    comments: [],
    createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'])
        : null,
    timestamp: json['timestamp'] != null
        ? DateTime.tryParse(json['timestamp'])
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
