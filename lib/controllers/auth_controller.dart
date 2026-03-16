import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class AuthController extends GetxController {
  final storageService = StorageService();

  // Observable variables
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Getters
  bool get isLoggedIn => currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
    _initializeAuth();
  }

  // Initialize auth on app start
  Future<void> _initializeAuth() async {
    currentUser.value = storageService.getCurrentUser();
  }

  // Register - Save to local storage only
  Future<void> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      // Create user with local data
      final user = UserModel(
        id: DateTime.now().toString(),
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(), password: '',
      );

      // Save to local storage
      await storageService.saveUser(user);
      await storageService.saveToken('local_token_${user.id}');


Get.offAllNamed('/home');
      currentUser.value = user;
      error.value = '';
    } catch (e) {
      error.value = 'Registration failed: $e';
      currentUser.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Login - Check local storage only
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      // Get all users from storage
      final allUsers = storageService.getAllUsers();
      
      // Find user by email
      final user = allUsers.firstWhere(
        (u) => u.email == email,
        orElse: () => throw Exception('User not found'),
      );

      // In real app, you'd verify password
      // For local storage, we just check if user exists
      await storageService.saveToken('local_token_${user.id}');
      currentUser.value = user;
      error.value = '';
    } catch (e) {
      error.value = 'Login failed: $e';
      currentUser.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await storageService.logout();
      currentUser.value = null;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    }
  }

  // Clear error
  void clearError() {
    error.value = '';
  }
}