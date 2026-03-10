import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String query) {
    // Dummy search logic - replace with actual search implementation
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = [
          'Post: $query example',
          'User: @${query}user',
          'Hashtag: #$query',
          // Add more dummy results or integrate with real data
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const babyPink = Color.fromARGB(255, 243, 114, 133);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search for posts, users or hashtags',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[400],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
                    child: Text(
                      'Start typing to search for posts, users, or hashtags',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          _searchResults[index].startsWith('Post:')
                              ? Icons.article
                              : _searchResults[index].startsWith('User:')
                                  ? Icons.person
                                  : Icons.tag,
                          color: babyPink,
                        ),
                        title: Text(_searchResults[index]),
                        onTap: () {
                          // Handle tap on search result
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
