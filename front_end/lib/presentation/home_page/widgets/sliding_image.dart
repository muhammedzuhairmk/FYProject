
// ignore_for_file: avoid_unnecessary_containers, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Event {
  final int id;
  final String imageUrl;

  Event({
    required this.id,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }
}

class SlidingImage extends StatefulWidget {
  final int? id;

  const SlidingImage({
    this.id,
    super.key,
  });
  @override
  _SlidingImageState createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
   bool isLoading = true;
   List<Map<dynamic,dynamic>> imageList = [];

Future<void> fecthSlidingImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(admineventview),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          imageList = List<Map<String, dynamic>>.from(responseData['data']);                    
        });
      
        print('Response Body: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsms. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }

@override
  void initState() {
    super.initState();

    fecthSlidingImage();

   
  }
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
                    ImageUrl+ url['thumbnail']['image'],
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

