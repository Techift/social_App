// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:social_app/screens/feed_screen.dart';
// import 'package:social_app/screens/messages_screen.dart';
// import 'package:social_app/screens/notifications_screen.dart';
// import 'package:social_app/screens/profile_screen.dart';
// import 'package:social_app/services/auth_service.dart';
// import 'package:social_app/screens/auth/login.dart';
// // import 'package:provider/provider.dart';
// // import 'package:social_app/provider/post_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/auth_controller.dart';
// import '../../controllers/post_controller.dart';
// import '../../routes/app_routes.dart';

// // class _HomeScreenState extends State<HomeScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     final authController = Get.find<AuthController>();
// //     final postController = Get.find<PostController>();


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final _postController = TextEditingController();
//    final authController = Get.find<AuthController>();
//   // final postController = Get.find<PostController>();

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
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
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
import 'package:social_app/screens/feed_screen.dart';
import 'package:social_app/screens/messages_screen.dart';
import 'package:social_app/screens/notifications_screen.dart';
import 'package:social_app/screens/profile_screen.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/post_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _postController = TextEditingController();
  
  // Find your controllers
  final authController = Get.find<AuthController>();
  final postController = Get.find<PostController>();

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FeedScreen(),
      MessagesScreen(),
      const NotificationsScreen(),
      const ProfileScreen(),
    ];
  }

  void _showPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Create Post",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _postController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border:UnderlineInputBorder(borderSide: BorderSide.none)
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Image upload coming soon',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_postController.text.isNotEmpty) {
                final userId = authController.currentUser.value!.id;
                // Fixed: Using GetX Controller instead of Provider
                postController.createPost(_postController.text.trim(), null, userId); 
                _postController.clear();
                Navigator.pop(context);
                print('posted');
              }
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    // GetX Obx allows this UI to react if the user logs out suddenly
    return Obx(() {
      // Check if user is logged in using your AuthController logic
      if (authController.currentUser.value == null) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Please log in to continue'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/login'), // Using GetX routing
                  child: const Text('Go to Login'),
                ),
              ],
            ),
          ),
        );
      }

      final username = authController.currentUser.value?.username ?? 'User';

      return Scaffold(
        appBar: _currentIndex == 0
            ? AppBar(
                title: Text(
                  'Welcome, $username',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: babyPink,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = 3),
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: babyPink),
                      ),
                    ),
                  ),
                ],
              )
            : null,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // Feed View with the "Create Post" button at the top
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () => _showPostDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: babyPink,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Create New Post'),
                  ),
                ),
                const Divider(height: 1),
                Expanded(child: _pages[0]),
              ],
            ),
            _pages[1],
            _pages[2],
            _pages[3],
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: babyPink,
          unselectedItemColor: Colors.grey,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      );
    });
  }
}
