import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/calender_page/widget/screen_calender.dart';
//import 'widgets/event_container.dart';
import 'widgets/main_container.dart';

class ScreenMain extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends State<ScreenMain> {
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
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text(
                'EventSnap',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: _isScrolled ? Colors.black : Colors.white,
            elevation: _isScrolled ? 4 : 0,
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
            ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: UserAccountsDrawerHeader(
                  accountName: const Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: const Text(
                    "email@gail.com",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset("assets/images/image.jpg"),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: BackGroundColor,
                    border: Border.all(
                        width: 2.0, color: Color.fromARGB(255, 114, 163, 181)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Account',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (contex) =>  ScreenMain(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.list_alt_sharp,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Event List',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) =>  ScreenCaleneder(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Admin panel',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.calendar_month_rounded,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Calender',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.upload_rounded,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Upload image',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.collections_rounded,
                  color: BackGroundColor,
                ),
                title: const Text(
                  'Event Album',
                  style: TextStyle(color: drawertext),
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.0, color: Color.fromARGB(255, 114, 163, 181)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: BackGroundColor,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: drawertext),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        //appBar: AppBarWidget(),
        body: Center(
          child: MainContainer(),
        ));
  }
}
