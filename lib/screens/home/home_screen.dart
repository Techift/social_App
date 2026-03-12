// import 'package:flutter/material.dart';
// import 'package:social_app/screens/feed_screen.dart';
// import 'package:social_app/screens/messages_screen.dart';
// import 'package:social_app/screens/notifications_screen.dart';
// import 'package:social_app/screens/profile_screen.dart';
// import 'package:social_app/services/auth_service.dart';
// import 'package:social_app/screens/auth/login.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/provider/post_provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final _authService = AuthService();
//   final _postController = TextEditingController();

//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//        FeedScreen(),
//       MessagesScreen(),
//       const NotificationsScreen(),
//       const ProfileScreen(),
//     ];
//   }

//   void _showPostDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Post",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _postController,
//               maxLines: 5,
//               decoration: InputDecoration(
//                 hintText: "What's on your mind?",
//               ),
//             ),
//             SizedBox(height: 10),
//             // Placeholder for images
//             Container(
//               height: 30,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Center(
//                 child: Text(
//                   'Image upload coming soon',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (_postController.text.isNotEmpty) {
//                 context.read<PostProvider>().addPost(_postController.text);
//                 _postController.clear();
//                 Navigator.pop(context);
//               }
//             },
//             child: Text('Post'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _postController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const babyPink = Color(0xFFFFB6C1);
//     final username = _authService.currentUser?.username ?? 'User';

//     // Check if user is logged in
//     if (!_authService.isLoggedIn) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Please log in to continue'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => Login()),
//                   );
//                 },
//                 child: Text('Go to Login'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: _currentIndex == 0
//           ? AppBar(
//               title: Text(
//                 'Welcome, $username',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
//               ),
//               automaticallyImplyLeading: false,
//               elevation: 0,
//               backgroundColor: babyPink.withValues(alpha: 0.9),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() => _currentIndex = 3);
//                     },
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.person, color: Colors.pink[300]),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : null,
//       body: _currentIndex == 0
//           ? Column(
//               children: [
//                 Divider(height: 1),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () => _showPostDialog(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: babyPink,
//                       foregroundColor: Colors.white,
//                       minimumSize: Size(double.infinity, 50),
//                     ),
//                     child: Text('Create New Post'),
//                   ),
//                 ),
//                 Expanded(child: IndexedStack(index: 0, children: [_pages[0]])),
//               ],
//             )
//           : IndexedStack(index: _currentIndex, children: _pages),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: babyPink,
//         unselectedItemColor: Colors.grey[600],
//         onTap: (i) => setState(() => _currentIndex = i),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Feed',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message_outlined),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications_none),
//             label: 'Notifications',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/post_controller.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final postController = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Me2U'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.logout();
              Get.offNamed(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (postController.posts.isEmpty) {
          return const Center(
            child: Text('No posts yet. Be the first to post!'),
          );
        }

        return ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite_border),
                            const SizedBox(width: 4),
                            Text('${post.likes}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.comment_outlined),
                            const SizedBox(width: 4),
                            Text('${post.comments}'),
                          ],
                        ),
                        const Icon(Icons.share_outlined),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
