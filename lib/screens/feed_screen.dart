import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/widgets/comment_widget.dart';
import '../controllers/post_controller.dart';
import '../controllers/auth_controller.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({super.key});

  final PostController postController = Get.find();
  final AuthController authController = Get.find();

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final posts = postController.posts;

        if (posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.feed, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No posts yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first post!',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return Card(
              color: const Color.fromARGB(255, 253, 181, 198),
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// USER INFO
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color.fromARGB(
                            255,
                            253,
                            170,
                            198,
                          ),
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.authorName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                _formatTimeAgo(
                                  post.timestamp ?? DateTime.now(),
                                ),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                          onSelected: (value) {
                            if (value == 'edit') {
                              // Call your edit post function
                              postController.editPost(post);
                            } else if (value == 'delete') {
                              // Call your delete post function
                              postController.deleteAllPost(post);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text('Edit Post'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete Post'),
                                ),
                              ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// POST CONTENT
                    Text(post.content, style: const TextStyle(fontSize: 15)),

                    const SizedBox(height: 10),

                    /// IMAGE PLACEHOLDER
                    if (post.imageUrls != null && post.imageUrls!.isNotEmpty)
                      Column(
                        children: post.imageUrls!
                            .map(
                              (url) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(url), // local path
                                    width: double.infinity,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    else
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[400],
                            size: 48,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),

                    /// ACTIONS
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            post.likes.contains(
                                  authController.currentUser.value!.id,
                                )
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            postController.toggleLike(
                              post,
                              authController.currentUser.value!.id,
                            );
                          },
                        ),

                        Text("${post.likes.length} likes"),

                        const SizedBox(width: 16),

                        IconButton(
                          icon: Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            postController.toggleCommentField(post);
                          },
                        ),
                        Text("${post.comments.length} comments"),

                        // Text('${post.comments}'),
                      ],
                    ),
                    Column(
                      children: post.comments.map((comment) {
                        return ListTile(
                          title: Text(comment.username),
                          subtitle: Text(comment.content),
                        );
                      }).toList(),
                    ),

                    CommentInput(post: post),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
