import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const babyPink = Color.fromARGB(255, 237, 66, 91);

    final recentChats = List.generate(12, (i) => 'Friend ${i + 1}');

    return SafeArea(
      child: Column(
        children: [
          // Horizontally scrollable row of chat avatars
          SizedBox(
            height: 110,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  ...List.generate(
                    recentChats.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: babyPink,
                            child: const Icon(Icons.person, color: Colors.white, size: 28),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 68,
                            child: Text(
                              recentChats[index],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(),

          // Chat list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: recentChats.length,
              separatorBuilder: (context, i) => const Divider(indent: 84),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: CircleAvatar(radius: 28, backgroundColor: babyPink, child: const Icon(Icons.person, color: Colors.white)),
                  title: Text(recentChats[i]),
                  subtitle: const Text('Hey, let\'s catch up soon.'),
                  trailing: const Text('2:14 PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
