
// ignore_for_file: avoid_unnecessary_containers, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlidingImage extends StatefulWidget {
  @override
  _SlidingImageState createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
  final List<String> imageList = [
     'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
     'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
     'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
     'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
     'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
    // Add more image URLs as needed
    // ... (your list of image URLs)
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Column(
        children: [
          CarouselSlider(
            items: imageList.map((url) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0), // Set image border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Set image border radius
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    height: 180,
                    width: 400,
                  ),
                ),
              );
            }).toList(),


            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              aspectRatio: 2 / 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            ' $_currentIndex',
            style:const  TextStyle(fontSize: 1),
          ),
        ],
      ),
    );
  }
}

