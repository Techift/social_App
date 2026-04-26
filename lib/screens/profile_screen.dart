import 'package:flutter/material.dart';
import 'package:social_app/screens/auth/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'My Profile',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Edit Username"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit Profile"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),

                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text("Remove Photo"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text("Logout"),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Edit', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        backgroundColor: babyPink.withValues(alpha: 0.9),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/images/screen2.png"),
                    ),

                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'I am a software developer',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.email_outlined),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Email'), Text('johndoe@gmail.com')],
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.phone_android_outlined),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Phone'), Text('+1 (555) 123-4567')],
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.facebook_outlined),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Facebook'), Text('Add a Facebook account')],
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location'),
                    Text('123 Main Street, City, State 12345'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
