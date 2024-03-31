import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/routes.dart';

class AlbumItem {
  final String imagePath;
  final String date;

  AlbumItem({required this.imagePath, required this.date});
}

class AlbumListPage extends StatefulWidget {
  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  List<Map<dynamic, dynamic>> presentEvents = [];

  Future<void> fetchPresentEventList() async {
    presentEvents = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.get(
        Uri.parse(presenteventList),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          presentEvents = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        print('Failed to fetch present gallery items. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery items: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPresentEventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album List'),
      ),
      body: ListView.builder(
        itemCount: presentEvents.length,
        itemBuilder: (context, index) {
          final item = presentEvents[index];
          final gallery = item['gallery'] as List<dynamic>?;

          if (gallery != null && gallery.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['date'].toString()), // Display date if needed
                  SizedBox(height: 5),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: gallery.map<Widget>((imageData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                imageUrl: ImageUrl + imageData['image'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              ImageUrl + imageData['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(); // Return an empty SizedBox if gallery is empty
          }
        },
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Size Image'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context); // Go back when tapped
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
