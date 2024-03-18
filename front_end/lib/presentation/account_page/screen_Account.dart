// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, file_names, avoid_print, unused_local_variable, non_constant_identifier_names, unused_element

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constant/routes.dart';
import 'profile.dart';



class AccountPage extends StatefulWidget {

  final int? id;

  const AccountPage({
    this.id,
    super.key,
  });

  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<AccountPage> {
  
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController admissionYear = TextEditingController();
  TextEditingController admissionNumber = TextEditingController();
  String avatar = "";

  bool isLoading = true;

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
          name.text = ProfileData['data']['name'] ?? '';
          phoneNumber.text = ProfileData['data']['phoneNumber'].toString();
          email.text = ProfileData['data']['email'] ?? '';
          admissionNumber.text = ProfileData['data']['admissionNumber'].toString() ;
          admissionYear.text = ProfileData['data']['admissionYear'].toString() ;
         
          avatar = ProfileData['data']['avatar'] ?? '';
        });
      } else {
        print(
            'Failed to fetch Profile details. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching Profile details: $error');
    }
  }
 
  @override
  void initState() {
    super.initState();

    fetchProfile();
  }
  
  Uint8List? _image;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:  ListView(
          children: [
            
            const SizedBox(height: 5),

           
              Center(
        heightFactor: 1.2,
        child: Stack(
          children: [
            _image != null ? CircleAvatar( radius: 60, backgroundImage: MemoryImage(_image!))
                : CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage("$ImageUrl$avatar"),
                  ),
          ]
          ),
              ),

Container(
  height: 50,
  margin: const EdgeInsets.symmetric(horizontal: 25),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
       const  Text(
          "Account Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
       const  SizedBox(width: 0),
        IconButton(
          hoverColor: const Color.fromARGB(255, 78, 131, 175),
          icon: const Icon(Icons.person_add),
          onPressed: () {
            // Navigate to the AccountPage using Navigator
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  AccountProfilePage()),
            );
          },
        ),
      ],
    ),
  ),
),

    const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.all(30),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                            ),
                              
                              child: Column(
                              children: [
                               
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Name';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: name,
                                  decoration: InputDecoration(
                                    icon:const Icon(Icons.person),
                                    filled: true,
                                    fillColor: mainColor,
                                    contentPadding: const EdgeInsets.all(15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color when focused
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10,),
                                
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phoneNumber';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: phoneNumber,
                                  decoration: InputDecoration(
                                    icon:const Icon(Icons.phone),
                                    filled: true,
                                    fillColor: mainColor,
                                    contentPadding: const EdgeInsets.all(15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color when focused
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                               
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Gmail';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: email,
                                  decoration: InputDecoration(
                                    icon:const Icon(Icons.mail),
                                    filled: true,
                                    fillColor: mainColor,
                                    contentPadding: const EdgeInsets.all(15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color when focused
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                                
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter admission year';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: admissionYear,
                                  decoration: InputDecoration(
                                    icon:const Icon(Icons.calendar_month),
                                    filled: true,
                                    fillColor: mainColor,
                                    contentPadding: const EdgeInsets.all(15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color when focused
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                               
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter admission year';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: admissionNumber,
                                  decoration: InputDecoration(
                                    icon:const Icon(Icons.confirmation_number),
                                    filled: true,
                                    fillColor: mainColor,
                                    contentPadding: const EdgeInsets.all(15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .transparent, // Set the border color when focused
                                      ),
                                    ),
                                 ),
                                                       ),
                              ],
                            ),
                          ),     
                     ],
                   ),
               ),
            );
          }

}




