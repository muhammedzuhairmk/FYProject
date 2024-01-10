import 'package:flutter/material.dart';


<<<<<<< HEAD
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
    Future.delayed(Duration(seconds: 1), () {
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

=======
class EventDayContainer extends StatelessWidget {
  const EventDayContainer({super.key});
>>>>>>> 2a32e55c94734a4e6a646cf68ff499370e74050e
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 3, // Change this to the number of containers you want to slide
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.blue, // Change the color or add your widget here
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
