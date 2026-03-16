import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'services/storage_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();

//   Hive.registerAdapter(UserModelAdapter());
//   Hive.registerAdapter(PostModelAdapter());
//   Hive.registerAdapter(CommentModelAdapter());
//   await Hive.openBox<PostModel>('PostsBox');
//   // Initialize storage
//   await StorageService().init();
//   await Hive.deleteBoxFromDisk('users');
//   await Hive.deleteBoxFromDisk('posts');

//   Get.put(AuthController());
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Delete old boxes first (only for dev)
  if (await Hive.boxExists('users')) await Hive.deleteBoxFromDisk('users');
  if (await Hive.boxExists('posts')) await Hive.deleteBoxFromDisk('posts');

  // Register adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());

  // Open boxes
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<PostModel>('posts');

  // Initialize storage
  await StorageService().init();

  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Me2U',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
