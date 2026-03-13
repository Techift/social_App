// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:social_app/provider/post_provider.dart';
// import 'package:social_app/services/auth_service.dart';

// class FeedScreen extends StatelessWidget {
//   const FeedScreen({super.key});

//   String _formatTimeAgo(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     if (difference.inDays > 0) {
//       return '${difference.inDays}d ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours}h ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes}m ago';
//     } else {
//       return 'Just now';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const babyPink = Color(0xFFFFB6C1);
//     final authService = AuthService();

//     return SafeArea(
//       child: Consumer<PostProvider>(
//         builder: (context, postProvider, child) {
//           final posts = postProvider.posts;

//           if (posts.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.feed, size: 64, color: Colors.grey[400]),
//                   const SizedBox(height: 16),
//                   Text(
//                     'No posts yet',
//                     style: TextStyle(fontSize: 18, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Create your first post!',
//                     style: TextStyle(color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               final username = authService.currentUser?.username ?? 'User';

//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 22,
//                             backgroundColor: babyPink,
//                             child: const Icon(Icons.person, color: Colors.white),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   post.authorName, 
//                                   style: const TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   _formatTimeAgo(post.timestamp),
//                                   style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Icon(Icons.more_horiz, color: Colors.grey[600]),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Text(post.content),
//                       const SizedBox(height: 8),
//                       // Placeholder for post image (you can add image functionality later)
//                       Container(
//                         height: 160,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.image,
//                             color: Colors.grey[400],
//                             size: 48,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(Icons.favorite_border, color: babyPink),
//                           const SizedBox(width: 8),
//                           const Text('0'),
//                           const SizedBox(width: 16),
//                           Icon(Icons.chat_bubble_outline, color: Colors.grey[600]),
//                           const SizedBox(width: 8),
//                           const Text('0'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// class FeedScreen extends StatefulWidget {
//   @override
//   _FeedScreenState createState() => _FeedScreenState();
// }

// class _FeedScreenState extends State<FeedScreen> {
//   final List<Map<String, dynamic>> _posts = [];
//   final TextEditingController _controller = TextEditingController();

//   void _handlePost() async {
//     final text = _controller.text;
//     if (text.isEmpty) return;

//     // 1. Create a temporary post object
//     final tempPost = {
//       'id': DateTime.now().toString(),
//       'text': text,
//       'isSending': true,
//     };

//     // 2. UPDATE UI IMMEDIATELY
//     setState(() {
//       _posts.insert(0, tempPost); // Add to the top of the list
//       _controller.clear();
//     });

//     try {
//       // 3. Perform the background network task
//       // Replace this with your actual API/Firebase call
//       await Future.delayed(Duration(seconds: 2)); 

//       // 4. Update the status once finished
//       setState(() {
//         int index = _posts.indexWhere((p) => p['id'] == tempPost['id']);
//         if (index != -1) {
//           _posts[index]['isSending'] = false;
//         }
//       });
//     } catch (e) {
//       // 5. If it fails, remove it and alert the user
//       setState(() {
//         _posts.removeWhere((p) => p['id'] == tempPost['id']);
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to post")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // TextField(controller: _controller),
//         // ElevatedButton(onPressed: _handlePost, child: Text("habd")),
//         // Expanded(
//         //   child: ListView.builder(
//         //     itemCount: _posts.length,
//         //     itemBuilder: (context, index) {
//         //       final post = _posts[index];
//         //       return ListTile(
//         //         title: Text(post['text']),
//         //         // Visual cue for "Real-time" background syncing
//         //         trailing: post['isSending'] 
//         //           ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
//         //           : Icon(Icons.check, color: Colors.green),
//         //       );
//         //     },
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/post_controller.dart';
// import '../../controllers/auth_controller.dart';

// class FeedScreen extends StatelessWidget {
//   const FeedScreen({super.key});

//   // Helper for time formatting
//   String _formatTimeAgo(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);
//     if (difference.inDays > 0) return '${difference.inDays}d ago';
//     if (difference.inHours > 0) return '${difference.inHours}h ago';
//     if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
//     return 'Just now';
//   }

//   @override
//   Widget build(BuildContext context) {
//     const babyPink = Color(0xFFFFB6C1);
    
//     // Find our controllers
//     final postController = Get.find<PostController>();
//     final authController = Get.find<AuthController>();

//     return SafeArea(
//       child: Obx(() {
//         final posts = postController.posts;

//         if (posts.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.feed, size: 64, color: Colors.grey[400]),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No posts yet',
//                   style: TextStyle(fontSize: 18, color: Colors.grey[600]),
//                 ),
//                 Text(
//                   'Be the first to share something!',
//                   style: TextStyle(color: Colors.grey[500]),
//                 ),
//               ],
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
            
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // --- Header: Avatar + Name + Sending Status ---
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundColor: babyPink,
//                           child: const Icon(Icons.person, color: Colors.white),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 post.authorName ?? 'User',
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 _formatTimeAgo(post.timestamp),
//                                 style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Visual cue for background syncing
//                         if (post.isSending ?? false)
//                           const SizedBox(
//                             width: 15,
//                             height: 15,
//                             child: CircularProgressIndicator(strokeWidth: 2, color: babyPink),
//                           )
//                         else
//                           Icon(Icons.check_circle, color: Colors.green[300], size: 18),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
                    
//                     // --- Content ---
//                     Text(
//                       post.content,
//                       style: const TextStyle(fontSize: 15, height: 1.4),
//                     ),
                    
//                     const SizedBox(height: 12),
                    
//                     // --- Optional Image Placeholder ---
//                     if (post.imageUrls != null)
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(post.imageUrls!.first, fit: BoxFit.cover),
//                       )
//                     else
//                       Container(
//                         height: 120,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Icon(Icons.image_outlined, color: Colors.grey[300], size: 40),
//                       ),
                    
//                     const SizedBox(height: 12),
                    
//                     // --- Footer: Like & Comment ---
//                     Row(
//                       children: [
//                         _PostAction(icon: Icons.favorite_border, label: '0', color: babyPink),
//                         const SizedBox(width: 20),
//                         _PostAction(icon: Icons.chat_bubble_outline, label: '0', color: Colors.grey[600]!),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// // Simple helper widget for Like/Comment buttons
// class _PostAction extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   const _PostAction({required this.icon, required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 20),
//         const SizedBox(width: 5),
//         Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../controllers/auth_controller.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({super.key});

  final PostController postController = Get.find();
  final AuthController authController = Get.find();

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    return SafeArea(
      child: Obx(() {
        final posts = postController.posts;

        if (posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.feed, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No posts yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first post!',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return Card(
              color: Colors.pink,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// USER INFO
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: babyPink,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.authorName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                _formatTimeAgo(post.timestamp ?? DateTime.now()),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Icon(Icons.more_horiz, color: Colors.grey[600]),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// POST CONTENT
                    Text(
                      post.content,
                      style: const TextStyle(fontSize: 15),
                    ),

                    const SizedBox(height: 10),

                    /// IMAGE PLACEHOLDER
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[400],
                          size: 48,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// ACTIONS
                    Row(
                      children: [
                        Icon(Icons.favorite_border, color: babyPink),
                        const SizedBox(width: 8),
                        Text('${post.likes}'),

                        const SizedBox(width: 16),

                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text('${post.comments}'),
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