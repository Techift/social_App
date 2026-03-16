import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:social_app/controllers/auth_controller.dart';
import 'package:social_app/controllers/post_controller.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';

class CommentInput extends StatelessWidget {

  final PostModel post;

  CommentInput({required this.post});

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final postController = Get.find<PostController>();
    final authController = Get.find<AuthController>();

    return Row(
      children: [

        Expanded(
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: "Write a comment...",
            ),
          ),
        ),

        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {

            final user = authController.currentUser.value!;

            final comment = CommentModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              postId: post.id,
              userId: user.id,
              username: user.username,
              content: commentController.text,
            );

            postController.addComment(post, comment);

            commentController.clear();
          },
        )
      ],
    );
  }
}