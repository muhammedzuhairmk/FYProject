import 'package:flutter/material.dart';

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
  List<AlbumItem> _albumItems = [
    AlbumItem(imagePath: 'assets/images/image.jpg', date: '2024-03-25'),
    AlbumItem(imagePath: 'assets/images/image.jpg', date: '2024-03-25'),
    AlbumItem(imagePath: 'assets/images/image.jpg', date: '2024-03-26'),
    AlbumItem(imagePath: 'assets/images/image.jpg', date: '2024-03-26'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album List'),
      ),
      body: ListView.builder(
        itemCount: _albumItems.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: _buildRowImages(index),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildRowImages(int index) {
    return _albumItems
        .where((item) => item.date == _albumItems[index].date)
        .map((item) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Image.asset(
          item.imagePath,
          width: 150,
          height: 120,
          fit: BoxFit.cover,
        ),
      );
    }).toList();
  }
}
