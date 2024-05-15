import 'package:anime/utils/AnimeSearchBar.dart';
import 'package:anime/utils/cardView.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _searchQuery; // Declare _searchQuery here

  @override
  void initState() {
    super.initState();
    _searchQuery = ''; // Initialize search query
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimeSearchBar(
            onSubmitted: _handleSearch,
          ),
          Expanded(
            child: CardView(
              searchQuery: _searchQuery, // Pass searchQuery to CardView
            ),
          ),
        ],
      ),
    );
  }
}
