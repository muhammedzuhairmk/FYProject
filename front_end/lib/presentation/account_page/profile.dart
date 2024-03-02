// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProfilePage extends StatefulWidget {
  final int? id;

  const AccountProfilePage({
    this.id,
    super.key,
  });

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController admissionYear = TextEditingController();
  TextEditingController admissionNumber = TextEditingController();
  String avatar = "";

  bool isLoading = false;

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

  Future<void> submitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

    try {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          isLoading = true;
        });
        final request = http.MultipartRequest(
          'PATCH',
          Uri.parse(profile),
        )
          ..headers['Authorization'] = 'Bearer $token'
          ..headers['Accept'] = 'application/json'
          ..headers['Content-Type'] = 'multipart/form-data'
          ..fields['name'] = name.text
          ..fields['phoneNumber'] = phoneNumber.text
          ..fields['email'] = email.text
           ..fields['admissionNumber'] = admissionNumber.text
          ..fields['admissionYear'] = admissionYear.text;

        if (selectedImage != null) {
          request.files.add(
            http.MultipartFile(
              'avatar',
              http.ByteStream.fromBytes(_image!),
              _image!.length,
              filename: 'avatar.jpg',
            ),
          );
        }

        final response = await request.send();
        final responseData = await response.stream.bytesToString();

        print('Response Body: $responseData');

        if (response.statusCode == 201) {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context, "reload");
          CustomDialog.showDialogBox(
            context,
            'Updated successfully',
            'Profile updated successfully.',
          );
        } else {
          setState(() {
            isLoading = false;
          });
          CustomDialog.showDialogBox(
            context,
            'Failed to Update',
            'Profile updating failed. Status: ${response.statusCode}',
          );
        }
      }
    } catch (error) {
      CustomDialog.showDialogBox(
        context,
        'Network Error!',
        'Check your connection!',
      ); 
    }
  }

  Future<void> _pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 150,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Page",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 38,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  _image != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: MemoryImage(_image!),
                                        )
                                      : (avatar.isNotEmpty
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(avatar),
                                            )
                                          : const CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  'assets/images/user.jpg'),
                                            )),
                                  Positioned(
                                    bottom: -10,
                                    left: 60,
                                    child: IconButton(
                                      onPressed: () {
                                        _pickImage();
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                            controller: name,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
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
                          const SizedBox(
                            height: 12,
                          ),
                          
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phoneNumber';
                              }
                              return null;
                            },
                            controller: phoneNumber,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.phone),
                              filled: true,
                              fillColor: Colors.white,
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
                            readOnly: false,
                            controller: email,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.mail),
                              filled: true,
                              fillColor: Colors.white,
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
                            readOnly: false,
                            controller: admissionYear,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.calendar_month),
                              filled: true,
                              fillColor: Colors.white,
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
                                return 'Please enter admission number';
                              }
                              return null;
                            },
                            readOnly: false,
                            controller: admissionNumber,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.confirmation_num),
                              filled: true,
                              fillColor: Colors.white,
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
                          
                          const SizedBox(height: 20),
                          TextButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (builder) =>
                                //             ResetPassword(email: email.text)));
                              },
                              child: const Text(
                                "Reset Password",
                                style: TextStyle(color: Colors.red),
                              )),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(255, 56, 105, 148)                                 ),
                                        width: double.infinity,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: isLoading
                                          ? null
                                          : () async {
                                              await submitData();
                                            },
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ))
                                          : const Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[500],
                                        ),
                                        width: double.infinity,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              Navigator.pop(context, "");
                                            },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
