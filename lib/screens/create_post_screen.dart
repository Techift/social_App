import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/provider/post_provider.dart';
import 'package:social_app/screens/feed_screen.dart';
import 'package:social_app/services/auth_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  final _authService = AuthService();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _createPost() {
    final content = _postController.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something to post')),
      );
      return;
    }

    Provider.of<PostProvider>(context, listen: false).addPost(content);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post created successfully!')),
    );

    _postController.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FeedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const babyPink = Color.fromARGB(255, 243, 52, 80);
    final username = _authService.currentUser?.username ?? 'User';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: babyPink,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text('Post as $username')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _postController,
                maxLines: null,
                expands: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What\'s happening?',
                ),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: babyPink),
              onPressed: _createPost,
              child: const Text('Post', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
