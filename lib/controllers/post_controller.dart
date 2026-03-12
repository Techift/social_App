import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/storage_service.dart';

class PostController extends GetxController {
  final storageService = StorageService();

  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  Future<void> loadPosts() async {
    isLoading.value = true;
    try {
      posts.value = storageService.getAllPosts();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPost(String content, List<String>? imageUrls) async {
    try {
      final post = PostModel(
        id: DateTime.now().toString(),
        userId: 'current_user_id',
        content: content,
        likes: 0,
        comments: 0,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
        updatedAt: null, timestamp: DateTime.now(), authorName: 'Current User',
      );

      await storageService.savePost(post);
      posts.insert(0, post);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await storageService.deletePost(postId);
      posts.removeWhere((post) => post.id == postId);
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }
}