import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';


class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends State<AppBarWidget> {
  ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child:
         Text(
          'EventSnap',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
      )),
      backgroundColor: _isScrolled ? Colors.black : Colors.white,
      elevation: _isScrolled ? 4 : 0,
       leading: IconButton(
          icon: Icon(Icons.menu), 
          color: _isScrolled ? Colors.black : BackGroundColor,// You can use any icon you like
          onPressed: () {
            // Handle leading button press
            print('Leading button pressed');
          },
        ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: _isScrolled ? Colors.black : BackGroundColor,
          ),
          onPressed: () {
            // Add your search functionality here
          },
        ),
      ],
    );
  }
}
