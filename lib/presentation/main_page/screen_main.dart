import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/calender_page/widget/screen_calender.dart';
import 'package:front_end/presentation/home_page/screen_home.dart';
import 'package:front_end/presentation/main_page/widgets/navi_bar.dart';
import 'package:front_end/presentation/search_page/screen_search.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final _pages = [
    
      ScreenMain(),
      ScreenSrearch(),
      ScreenCaleneder(),
      
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: BackGroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(valueListenable: indexChangeNotifier , builder: (context, int index, _) {
          return _pages[index];
        },),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}