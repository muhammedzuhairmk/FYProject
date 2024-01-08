import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';

ValueNotifier<int> indexChangeNotifier =ValueNotifier(0);

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: indexChangeNotifier, builder: (context,int newIndex, _) {
      return BottomNavigationBar(
      currentIndex: newIndex,
      onTap: (index){
        indexChangeNotifier.value = index;
      },
      selectedItemColor:const  Color.fromARGB(255, 78, 131, 175),
      unselectedItemColor: BackGroundColor,
      selectedIconTheme:const  IconThemeData(color: Color.fromARGB(255, 78, 131, 175)),
      unselectedIconTheme: const IconThemeData(color: BackGroundColor),
      items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: 'search'),
                  BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded),label: 'event calender'),
    ]
    );
    },
    );
  }
}