import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardView extends StatefulWidget {
  final String searchQuery;

  CardView({required this.searchQuery});

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  List<Map<String, String>> animeList = [];
  late String _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = widget.searchQuery;
    fetchDataFromJikan();
  }

  Future<void> fetchDataFromJikan() async {
    try {
      String url = 'https://api.jikan.moe/v3/top/anime';
      if (_searchQuery.isNotEmpty) {
        url += '?q=$_searchQuery';
      }
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        setState(() {
          animeList = List.generate(jsonData['top'].length, (index) {
            return {
              'title': jsonData['top'][index]['title'],
              'thumbnailUrl': jsonData['top'][index]['image_url'],
              'websiteUrl': jsonData['top'][index]['url'],
            };
          });
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: animeList.map((anime) {
        String? title = anime['title'];
        String? thumbnailUrl = anime['thumbnailUrl'];
        String? websiteUrl = anime['websiteUrl'];
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              // Handle tap on the card
              // You can navigate to another page or perform any action here
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    thumbnailUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    websiteUrl!,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}