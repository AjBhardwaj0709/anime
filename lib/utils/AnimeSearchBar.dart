import 'package:flutter/material.dart';

class AnimeSearchBar extends StatefulWidget {
  final Function(String) onSubmitted;

  const AnimeSearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  _AnimeSearchBarState createState() => _AnimeSearchBarState();
}

class _AnimeSearchBarState extends State<AnimeSearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Search for anime...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onSubmitted: (value) {
          widget.onSubmitted(value);
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
