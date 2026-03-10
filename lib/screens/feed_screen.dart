import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/services/auth_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

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
    const babyPink = Color(0xFFFFB6C1);
    final authService = AuthService();

    return SafeArea(
      child: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          final posts = postProvider.posts;

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
              final username = authService.currentUser?.username ?? 'User';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: babyPink,
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.authorName, // Changed from username to post.authorName
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatTimeAgo(post.timestamp),
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.more_horiz, color: Colors.grey[600]),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(post.content),
                      const SizedBox(height: 8),
                      // Placeholder for post image (you can add image functionality later)
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
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.favorite_border, color: babyPink),
                          const SizedBox(width: 8),
                          const Text('0'),
                          const SizedBox(width: 16),
                          Icon(Icons.chat_bubble_outline, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          const Text('0'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
