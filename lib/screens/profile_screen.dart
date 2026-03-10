import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(radius: 36, backgroundColor: babyPink, child: Icon(Icons.person, color: Colors.white, size: 36)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('User Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 6),
                    Text('I am a software developer', style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
          // Expanded(
          //   child: GridView.builder(
          //     padding: const EdgeInsets.all(12),
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
          //     itemCount: 18,
          //     itemBuilder: (context, i) => Container(color: Colors.grey[300]),
          //   ),
          // )
        ],
      ),
    );
  }
}
