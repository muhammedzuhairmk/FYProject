import 'package:flutter/material.dart';


class AutoSlideContainer extends StatefulWidget {
  @override
  _AutoSlideContainerState createState() => _AutoSlideContainerState();
}

class _AutoSlideContainerState extends State<AutoSlideContainer> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Auto slide every 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:25 ),
    
      height: 250,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 32, // Change this to the number of containers you want to slide
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,  
                      ),
                    ],
                  ), // Change the color or add your widget here
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

