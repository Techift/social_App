import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class UserController extends GetxController {
  final storageService = StorageService();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    user.value = storageService.getCurrentUser();
  }

  Future<void> updateUser(UserModel updatedUser) async {
    isLoading.value = true;
    try {
      await storageService.updateUser(updatedUser);
      user.value = updatedUser;
    } finally {
      isLoading.value = false;
    }
  }
}