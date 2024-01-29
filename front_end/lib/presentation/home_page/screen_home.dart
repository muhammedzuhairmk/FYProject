//ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/account_page/screen_Account.dart';
import 'package:front_end/presentation/admin_page/admin_panel.dart';
import 'package:front_end/presentation/home_page/widgets/main_container.dart';
import '../event_list_page/widget/screen_event_list.dart';
import 'widgets/Notification.dart';

class ScreenMain extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends State<ScreenMain> {
  File? selectedIMage;

  final ScrollController _scrollController = ScrollController();
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
                color: _isScrolled ? Colors.black : backGroundColor,
              ),
              onPressed: () {
                _showNotificationDialog(context, " ");
              },
            ),
          ],
          iconTheme: const IconThemeData(color: backGroundColor)),

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
                    child: Image.asset(
                      "assets/images/image.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: backGroundColor,
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(255, 114, 163, 181)),
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
                color: backGroundColor,
              ),
              title: const Text(
                'Account',
                style: TextStyle(color: drawertext),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list_alt_sharp,
                color: backGroundColor,
              ),
              title: const Text(
                'Event List',
                style: TextStyle(color: drawertext),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => ScreenEventList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: backGroundColor,
              ),
              title: const Text(
                'Admin panel',
                style: TextStyle(color: drawertext),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_rounded,
                color: backGroundColor,
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
                color: backGroundColor,
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
                color: backGroundColor,
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
                margin: const EdgeInsets.all(75),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0,
                      color: const Color.fromARGB(255, 114, 163, 181)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: backGroundColor,
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAlertDialog(context);
        },
        backgroundColor: Colors.white,
        foregroundColor: backGroundColor,
        elevation: 0,
        shape: const CircleBorder(
            side: BorderSide(
          color: Color.fromARGB(255, 114, 163, 181),
          width: 2.0,
        )),
        child: const Icon(Icons.add),
      ),
      //appBar: AppBarWidget(),
      body: const Center(
        child: MainContainer(),
      ),
    );
  }

  //navigation_camara and upload part
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          color: backGroundColor,
                          hoverColor: const Color.fromARGB(255, 78, 131, 175),
                          icon: const Icon(Icons.camera),
                          onPressed: () {
                            // Handle camera icon press
                            _pickImageCamera();
                          },
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                            color: backGroundColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          color: backGroundColor,
                          hoverColor: const Color.fromARGB(255, 78, 131, 175),
                          icon: const Icon(Icons.upload),
                          onPressed: () {
                            // Handle upload icon press
                            _pickImageGallery();
                          },
                        ),
                        const Text(
                          'Upload',
                          style: TextStyle(
                            color: backGroundColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImageGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.160.240:3000/upload'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        selectedIMage!.path, // Use selectedIMage instead of compressedFile
      ),
    );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _pickImageCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.160.240:3000/upload'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        selectedIMage!.path, // Use selectedIMage instead of compressedFile
      ),
    );

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _showNotificationDialog(BuildContext context, String response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification'),
          content: const Text('This is a notification message.'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenNotification()));
                  },
                  icon: const Icon(Icons.navigate_next),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
