import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 2)
class CommentModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String postId;

  @HiveField(2)
  String userId;

  @HiveField(3)
  String username;

  @HiveField(4)
  String content;

  @HiveField(5)
  DateTime timestamp;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}