import 'package:get/get.dart';
import '../models/post_model.dart';
import '../services/storage_service.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart.io';

class PostController extends GetxController {
  final storageService = StorageService();
  final ImagePicker _picker = ImagePicker();

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

  Future<void> createPost(String content, List<String>? imageUrls, String userId) async {
    try {
      final post = PostModel(
        id: DateTime.now().toString(),
        userId: userId,
        content: content,
        likes: 0,
        comments: 0,
        imageUrls: List.from(imageUrls ?? []),
        createdAt: DateTime.now(),
        updatedAt:  DateTime.now(), 
        timestamp: DateTime.now(), 
        authorName: 'current user',
      );

      await storageService.savePost(post);
      posts.insert(0, post);
      // post.refresh();
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

  Future<List<String>?> pickImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        return pickedFiles.map((file) => file.path).toList();
      }
    } catch (e) {
      error.value = e.toString();
    }
    return null;
  }
}