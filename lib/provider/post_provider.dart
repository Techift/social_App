import 'package:flutter/material.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/services/auth_service.dart';

class PostProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  void addPost(String content) {
    final currentUser = _authService.currentUser;
    if (currentUser == null) return;

    _posts.insert(
      0,
      PostModel(
        id: DateTime.now().toString(),
        content: content,
        authorName: currentUser.username, // Use username for display
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clearPosts() {
    _posts.clear();
    notifyListeners();
  }
}
