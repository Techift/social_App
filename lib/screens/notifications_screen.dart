import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: babyPink.withValues(alpha: 0.9),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: List.generate(
          8,
          (i) => ListTile(
            leading: CircleAvatar(backgroundColor: babyPink, child: const Icon(Icons.notifications, color: Colors.white)),
            title: const Text('Someone liked your post'),
            subtitle: const Text('2h'),
          ),
        ),
      ),
    );
  }
}
