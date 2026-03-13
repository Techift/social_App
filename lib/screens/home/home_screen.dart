import 'dart:io';

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

final RxList<String> _selectedImages = <String>[].obs;

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

  // void _showPostDialog(BuildContext context) {
  //   _selectedImages.clear();
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => Padding(
  //       padding: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).viewInsets.bottom,
  //         left: 16,
  //         right: 16,
  //         top: 16,
  //       ),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   "Create Post",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 IconButton(
  //                   icon: const Icon(Icons.close),
  //                   onPressed: () => Navigator.pop(context),
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   controller: _postController,
  //                   maxLines: 5,
  //                   decoration: const InputDecoration(
  //                     hintText: "What's on your mind?",
  //                     border: UnderlineInputBorder(borderSide: BorderSide.none),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Container(
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey.shade300),
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: const Center(),
  //                 ),
  //               ],
  //             ),

  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: const Text('Cancel'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 if (_postController.text.isNotEmpty ||
  //                     _selectedImages.isNotEmpty) {
  //                   final userId = authController.currentUser.value!.id;
  //                   // Fixed: Using GetX Controller instead of Provider
  //                   postController.createPost(
  //                     _postController.text.trim(),
  //                     _selectedImages,
  //                     userId,
  //                   );
  //                   _postController.clear();
  //                   _selectedImages.clear();
  //                   Navigator.pop(context);
  //                   print('posted');
  //                 }
  //               },
  //               child: const Text('Post'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  void _showPostDialog(BuildContext context) {
    _selectedImages.clear(); // reset images every time
    showModalBottomSheet(
      isScrollControlled:
          true, // allows the sheet to resize when keyboard opens
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // keyboard safe
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
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

              /// Text input
              TextField(
                controller: _postController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),

              /// Image picker + previews
              Obx(
                () => _selectedImages.isEmpty
                    ? Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.image),
                            label: const Text("Add Images"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFFB6C1),
                              foregroundColor: const Color.fromARGB(
                                255,
                                22,
                                22,
                                22,
                              ),
                            ),
                            onPressed: () async {
                              final images = await postController.pickImages();
                              if (images != null)
                                _selectedImages.addAll(images);
                            },
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == _selectedImages.length) {
                              // Add more button
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Container(
                                  width: 50,
                                  height: 20,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final images = await postController
                                          .pickImages();
                                      if (images != null)
                                        _selectedImages.addAll(images);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: const Color(0xFFFFB6C1),
                                      foregroundColor: const Color.fromARGB(
                                        255,
                                        22,
                                        22,
                                        22,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Icon(Icons.add, size: 40),
                                  ),
                                ),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(_selectedImages[index]),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: -4,
                                    right: -4,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _selectedImages.removeAt(index),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ),

              const SizedBox(height: 12),

              /// Post button
              ElevatedButton(
                onPressed: () {
                  if (_postController.text.isNotEmpty ||
                      _selectedImages.isNotEmpty) {
                    final userId = authController.currentUser.value!.id;

                    final imagesCopy = List<String>.from(_selectedImages); // create a copy
                    postController.createPost(
                      _postController.text.trim(),
                      imagesCopy,
                      userId,
                    );
                    _postController.clear();
                    _selectedImages.clear();
                    Navigator.pop(context);
                    // print('posted');
                  }
                },
                child: const Text('Post'),
              ),
            ],
          ),
        ),
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
                  onPressed: () =>
                      Get.offAllNamed('/login'), // Using GetX routing
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }
}
