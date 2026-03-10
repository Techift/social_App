import 'package:flutter/material.dart';
import 'package:social_app/screens/feed_screen.dart';
import 'package:social_app/screens/search_screen.dart';
import 'package:social_app/screens/create_post_screen.dart';
import 'package:social_app/screens/notifications_screen.dart';
import 'package:social_app/screens/profile_screen.dart';
import 'package:social_app/services/auth_service.dart';
import 'package:social_app/screens/auth/login.dart';
import 'package:social_app/models/user_story.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _authService = AuthService();

  // Sample user stories data
  final List<UserStory> stories = [
    UserStory(
      username: 'your_story',
      imageUrl: 'assets/images/screen1.png',
      isViewed: false,
    ),
    UserStory(
      username: 'jane_smith',
      imageUrl: 'assets/images/screen2.png',
      isViewed: true,
    ),
    UserStory(
      username: 'alex_jones',
      imageUrl: 'assets/images/screen3.png',
      isViewed: false,
    ),
    UserStory(
      username: 'emma_wilson',
      imageUrl: 'assets/images/screen1.png',
      isViewed: false,
    ),
    UserStory(
      username: 'john_doe',
      imageUrl: 'assets/images/screen1.png',
      isViewed: false,
    ),
    UserStory(
      username: 'john_doe',
      imageUrl: 'assets/images/screen3.png',
      isViewed: false,
    ),
    UserStory(
      username: 'john_doe',
      imageUrl: 'assets/images/screen2.png',
      isViewed: false,
    ),
  ];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages
    _pages = const [
      FeedScreen(),
      SearchScreen(),
      CreatePostScreen(),
      NotificationsScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);
    final username = _authService.currentUser?.username ?? 'User';

    // Check if user is logged in
    if (!_authService.isLoggedIn) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please log in to continue'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: Text(
                'Welcome, $username',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: babyPink.withValues(alpha: 0.9),
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'logout', child: Text('Logout')),
                  ],
                  onSelected: (value) {
                    if (value == 'logout') {
                      _authService.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }
                  },
                ),
              ],
            )
          : null,
      body: _currentIndex == 0
          ? Column(
              children: [
                // User Stories Section
                Container(
                  height: 120,
                  color: babyPink.withValues(alpha: 0.9),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      final story = stories[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle story tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Viewing ${story.username}\'s story',
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: story.isViewed
                                        ? Colors.grey[400]!
                                        : babyPink,
                                    width: 3,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(story.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  story.username,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(height: 1),
                Expanded(child: IndexedStack(index: 0, children: [_pages[0]])),
              ],
            )
          : IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: babyPink,
        unselectedItemColor: Colors.grey[600],
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Feed',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create',
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
  }
}
