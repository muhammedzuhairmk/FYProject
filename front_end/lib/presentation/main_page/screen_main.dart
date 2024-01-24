import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:front_end/presentation/home_page/screen_home.dart';
import 'package:front_end/presentation/main_page/widgets/navi_bar.dart';
import 'package:front_end/presentation/search_page/screen_search.dart';


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


























// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }
// //  class _MyHomePageState extends State<MyHomePage> {

// // //   final get_storage = GetStorage();
// // //   @override
// // //   void initState() {
// // //     // TODO: implement initState
// // //     super.initState();

// // //     get_storage.writeIfNull('user', false);

// // //     Future.delayed(Duration(seconds: 2),() async{

// // //       print(get_storage.read('user'));
// // //        checkUserData();
// // //     });


// // //   }

// // //   checkUserData(){
// // //     if(get_storage.read('user').toString().isNotEmpty || get_storage.read('user') ){
// // //       Navigator.push(context, MaterialPageRoute(builder: (builder)=>ScreenNotification()));
// // //     }else{
// // //       Navigator.push(context, MaterialPageRoute(builder: (builder)=>Login()));
// // //     }
// // //   }
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Center(
// // //         child: CircularProgressIndicator(),
// // //       ),
// // //     );
// // //   }
// // // }