import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:front_end/presentation/home_page/screen_home.dart';
import 'package:front_end/presentation/main_page/widgets/navi_bar.dart';
import 'package:front_end/presentation/search_page/screen_search.dart';

import '../calender_page/ScreenCalender.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = [
    ScreenMain(),
    SearchPage(),
    ScreenEventList(),
    ScreenCalender(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backGroundColor,

      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
