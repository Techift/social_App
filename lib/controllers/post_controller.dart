import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:social_app/models/comment_model.dart';
import '../models/post_model.dart';
import '../services/storage_service.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/auth_controller.dart';
import 'package:social_app/screens/edit_screen.dart';

class PostController extends GetxController {
  final storageService = StorageService();
  final ImagePicker _picker = ImagePicker();
  final AuthController authController = Get.find<AuthController>();

  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
   var commentFieldVisible = <String, RxBool>{}.obs;

Future<void> initHive() async {
    var box = await Hive.openBox<PostModel>('posts');

    // ✅ Clear old posts that are saved with int comments
    await box.clear(); 

    // Load posts into observable
    posts.assignAll(box.values.toList());
  }


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
 var showCommentField = <String, RxBool>{};
   void toggleCommentField(PostModel post) {
    if (!showCommentField.containsKey(post.id)) {
      showCommentField[post.id] = false.obs;
    }
    showCommentField[post.id]!.value = !showCommentField[post.id]!.value;
  }

  bool isCommentFieldVisible(PostModel post) {
    return showCommentField[post.id]?.value ?? false;
  }

  Future<void> createPost(String content, List<String>? imageUrls, String userId) async {
    final user = authController.currentUser.value!;
    try {
      final post = PostModel(
        id: DateTime.now().toString(),
        userId: userId,
        content: content,
        likes: [],
        comments: [],
        imageUrls: List.from(imageUrls ?? []),
        createdAt: DateTime.now(),
        updatedAt:  DateTime.now(), 
        timestamp: DateTime.now(), 
        authorName: user.username,
      );

      await storageService.savePost(post);
      posts.insert(0, post);
      // post.refresh();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  void toggleLike(PostModel post, String userId) {

  if (post.likes.contains(userId)) {
    post.likes.remove(userId);
  } else {
    post.likes.add(userId);
  }

  post.save(); // important for Hive
  posts.refresh();
}

void addComment(PostModel post, CommentModel comment) {

  post.comments.add(comment);
  post.save();   // saves to Hive
  posts.refresh();
}
  void editPost(PostModel post) {
    // Navigate to edit screen
    Get.to(() => EditPostScreen(post: post));
  }

  void deleteAllPost(PostModel post) async {
    await post.delete();
    posts.remove(post);
    posts.refresh();
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