//ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_end/main.dart';
import 'package:front_end/presentation/splash_screen.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:front_end/presentation/account_page/screen_Account.dart';
import 'package:front_end/presentation/admin_page/admin_panel.dart';
import 'package:front_end/presentation/home_page/widgets/main_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constant/colors.dart';
import '../../core/constant/routes.dart';
import '../event_list_page/widget/screen_event_list.dart';
import 'widgets/Notification.dart';

var role;

class ScreenMain extends StatefulWidget implements PreferredSizeWidget {
  final int? id;

  const ScreenMain({
    this.id,
    super.key,
  });
  @override
  _AnimatedAppBarState createState() => _AnimatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends State<ScreenMain> {

   String name="";
   String email="";
   String avatar = "";
   var role;

bool visi=false;
   Future<void> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

    try {
      final response = await http.get(
        Uri.parse(profile),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> ProfileData = json.decode(response.body);

        // Populate form fields with existing data
        setState(() {
          name= ProfileData['data']['name'] ??'';
          
          email= ProfileData['data']['email'] ?? '';
          
          role=ProfileData['data']['role']??'';
         
          avatar = ProfileData['data']['avatar'] ?? '';
        });
        if(role=='admin'){
          visi=true;
        }
      } else {
        print(
            'Failed to fetch Profile details. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching Profile details: $error');
    }
  }
  

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    fetchProfile();
    
    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
      });
    });
  }
  
  Uint8List? _image;
  File? selectedIMage;

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
                color: _isScrolled ? Colors.black : mainColor,
              ),
              onPressed: () {
                _showNotificationDialog(context, " ");
              },
            ),
          ],
          iconTheme: const IconThemeData(color: mainColor)),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: UserAccountsDrawerHeader(
                accountName:  Text(
                  name,
                  // controller: name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  email,
                  // controller: email,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                currentAccountPicture:  
         Stack(
          children: [
            _image != null ? CircleAvatar( radius: 60, backgroundImage: MemoryImage(_image!))
                :  CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage("$ImageUrl$avatar"),
                  ),
          ]
          ),
                decoration: BoxDecoration(
                  color: mainColor,
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
                color: mainColor,
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
                color: mainColor,
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
            Visibility(visible: visi,
              child: ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings,
                  color: mainColor,
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
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_rounded,
                color: mainColor,
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
                color: mainColor,
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
                color: mainColor,
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
                    color: mainColor,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: drawertext),
                  ),
                  onTap: () async {
                    final sharepref = await SharedPreferences.getInstance();
                    sharepref.setBool(save_key_name, false);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
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
        foregroundColor: mainColor,
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
                          color: mainColor,
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
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          color: mainColor,
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
                            color: mainColor,
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
      Uri.parse('http://192.168.14.131:3000/upload'),
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
      Uri.parse('http://192.168.14.131:3000/upload'),
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
                            builder: (context) => NotificationPage()));
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
