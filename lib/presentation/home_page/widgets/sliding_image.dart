

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlidingImage extends StatefulWidget {
  @override
  _SlidingImageState createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
  final List<String> imageList = [
    'https://as1.ftcdn.net/v2/jpg/05/64/63/22/1000_F_564632207_YGJSy3IC0XinhqMKgR3lAQ6homLfmfm0.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRVvLaT8HkU_CjUfpMBvuGzTzR3ZNbfhAooseXildMB6XzSF2xxdTCPAjz1sJXP_RE_gs&usqp=CAU',
    'https://www.thestudyfalcon.com/blog/wp-content/uploads/2021/01/WhatsApp-Image-2021-01-08-at-9.55.52-AM.jpeg',
    'https://c8.alamy.com/comp/2NBB001/world-typing-day-banner-design-illustration-2NBB001.jpg',
    'data:image/jpeg;base64,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',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNzFdY0RNHjCNJIlVBUYAWmEzUU1MSOc7694Z7Y4GJFw&s',
    'https://c8.alamy.com/comp/2KF7DCA/2-december-world-computer-literacy-day-2KF7DCA.jpg',
    'https://img.freepik.com/free-vector/gradient-top-view-laptop-background_52683-6291.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
    'https://img.freepik.com/free-vector/software-testing-cartoon-banner-functional-test-methodology-programming-search-errors-bugs-website-platform-development-dashboard-usability-optimization-computer-pc-illustration_107791-3131.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
    'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais'
    // Add more image URLs as needed
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          CarouselSlider(
            items: imageList.map((url) {
              return Image.network(
                url,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enlargeCenterPage: true,
              aspectRatio: 2/1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            ' $_currentIndex',
            style: TextStyle(fontSize: 1),
          ),
        ],
      ),
    );
  }
}
