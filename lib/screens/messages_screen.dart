import 'package:flutter/material.dart';
import 'package:social_app/screens/chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Sample chat data
  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Alice Johnson',
      'lastMessage': 'Hey, how are you?',
      'time': '2m ago',
      'unread': 2,
      'avatar': 'A',
    },
    {
      'name': 'Bob Smith',
      'lastMessage': 'Thanks for the help!',
      'time': '1h ago',
      'unread': 0,
      'avatar': 'B',
    },
    {
      'name': 'Charlie Brown',
      'lastMessage': 'See you tomorrow',
      'time': '3h ago',
      'unread': 1,
      'avatar': 'C',
    },
    {
      'name': 'Diana Prince',
      'lastMessage': 'That sounds great!',
      'time': '1d ago',
      'unread': 0,
      'avatar': 'D',
    },
    {
      'name': 'Eve Wilson',
      'lastMessage': 'Let me check that',
      'time': '2d ago',
      'unread': 0,
      'avatar': 'E',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const babyPink = Color(0xFFFFB6C1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: babyPink.withValues(alpha: 0.9),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Search coming soon!')),
              );
            },
          ),
        ],
      ),
      body: _chats.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start a conversation!',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: babyPink,
                    child: Text(
                      chat['avatar'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    chat['name'],
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    chat['lastMessage'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (chat['unread'] > 0)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: babyPink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${chat['unread']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: chat['name'],
                          avatar: chat['avatar'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('New chat coming soon!')),
          );
        },
        backgroundColor: babyPink,
        child: Icon(Icons.add),
      ),
    );
  }
}
