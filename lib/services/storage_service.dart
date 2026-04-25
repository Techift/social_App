import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/post_model.dart'; 
import '../models/message_model.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';
  static const String _userBoxName = 'users';
  static const String _postsBoxName = 'posts';
  static const String _messagesBoxName = 'messages';

  late SharedPreferences _prefs;
  late Box<UserModel> _userBox;
  late Box<PostModel> _postsBox;
  late Box<MessageModel> _messagesBox;

  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();
  Future<void> init() async {
  _prefs = await SharedPreferences.getInstance();

  await Hive.initFlutter();

  // Register adapters only once
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(PostModelAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(MessageModelAdapter());
  }

  // TEMP FIX: remove corrupted post box
  if (await Hive.boxExists(_postsBoxName)) {
    await Hive.deleteBoxFromDisk(_postsBoxName);
  }

  _userBox = await Hive.openBox<UserModel>(_userBoxName);
  _postsBox = await Hive.openBox<PostModel>(_postsBoxName);
  _messagesBox = await Hive.openBox<MessageModel>(_messagesBoxName);
}

  // ============ Token Management ============
  
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  bool isTokenValid() {
    return getToken() != null && getToken()!.isNotEmpty;
  }

  // ============ User Management ============
  
  Future<void> saveUser(UserModel user) async {
    await _userBox.put(user.id, user);
    await _prefs.setString(_userKey, user.id);
  }

  UserModel? getCurrentUser() {
    final userId = _prefs.getString(_userKey);
    if (userId == null) return null;
    return _userBox.get(userId);
  }

  Future<void> updateUser(UserModel user) async {
    await _userBox.put(user.id, user);
  }

  // Get all users (for login verification)
  List<UserModel> getAllUsers() {
    return _userBox.values.toList();
  }

  // ============ Post Management ============
  
  Future<void> savePost(PostModel post) async {
    await _postsBox.put(post.id, post);
  }

  Future<void> savePosts(List<PostModel> posts) async {
    for (var post in posts) {
      await _postsBox.put(post.id, post);
    }
  }

  List<PostModel> getAllPosts() {
    return _postsBox.values.toList();
  }

  Future<void> deletePost(String postId) async {
    await _postsBox.delete(postId);
  }

  // ============ Message Management ============
  
  Future<void> saveMessage(MessageModel message) async {
    await _messagesBox.put(message.id, message);
  }

  List<MessageModel> getConversation(String userId1, String userId2) {
    return _messagesBox.values
        .where((msg) =>
            (msg.senderId == userId1 && msg.receiverId == userId2) ||
            (msg.senderId == userId2 && msg.receiverId == userId1))
        .toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  // ============ Cleanup ============
  
  Future<void> logout() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
    await _userBox.clear();
    await _postsBox.clear();
    await _messagesBox.clear();
  }
}

