import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final storageService = StorageService();
  final apiService = ApiService();

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

  // Register
  Future<void> register({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await apiService.post(
        '/auth/register',
        body: {
          'username': username,
          'email': email,
          'phoneNumber': phoneNumber,
          'password': password,
        },
      );

      final user = UserModel.fromJson(response['user']);
      final token = response['token'];

      await storageService.saveUser(user);
      await storageService.saveToken(token);

      currentUser.value = user;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      currentUser.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';

    try {
      final response = await apiService.post(
        '/auth/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      final user = UserModel.fromJson(response['user']);
      final token = response['token'];

      await storageService.saveUser(user);
      await storageService.saveToken(token);

      currentUser.value = user;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
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