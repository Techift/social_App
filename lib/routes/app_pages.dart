import 'package:get/get.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register.dart';
import '../screens/home/home_screen.dart';
import '../controllers/auth_controller.dart';
import '../controllers/post_controller.dart';
import '../controllers/user_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () =>  RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<AuthController>(() => AuthController());
        Get.lazyPut<PostController>(() => PostController());
        Get.lazyPut<UserController>(() => UserController());
      }),
    ),
  ];
}