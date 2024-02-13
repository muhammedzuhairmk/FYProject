// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../core/constant/routes.dart';
import 'screen_Account.dart';

class AccountProfilePage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneNumberNumberController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController admissionNumberController = TextEditingController();

  File? selectedIMage;
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              heightFactor: 1.2,
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 60, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 90,
                          backgroundImage: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                        ),
                  Positioned(
                      bottom: 0,
                      left: 140,
                      child: IconButton(
                          onPressed: () {
                            showImagePickerOption(context);
                          },
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: gmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberNumberController,
              decoration: const InputDecoration(
                labelText: 'phoneNumber Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: admissionYearController,
              decoration: const InputDecoration(
                labelText: 'Admission Year',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: admissionNumberController,
              decoration: const InputDecoration(
                labelText: 'Admission Number',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIMage != null) {
                    userProfile(
                      fullNameController.text,
                      gmailController.text,
                      phoneNumberNumberController.text,
                      admissionYearController.text,
                      admissionNumberController.text,
                      selectedIMage!,
                      'YOUR_AUTH_TOKEN_HERE', // replace with your auth token
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an image.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Update Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 9.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

 Future<void> userProfile(
  String name,
  String email,
  String phoneNumber,
  String admissionYear,
  String admissionNumber,
  File newImage,
  String token,
 ) async {
  try {
    final request = http.MultipartRequest('PATCH', Uri.parse(profile));

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Map<String, dynamic> changes = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'admissionYear': admissionYear,
      'admissionNumber': admissionNumber,
    };

    request.headers.addAll(headers);

    // Add text fields
    changes.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add image file
    request.files.add(await http.MultipartFile.fromPath('image', newImage.path));

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Profile updated successfully");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountPage()),
      );
    } else {
      throw Exception("Failed to update profile");
    }
  } catch (error) {
    print('Error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error updating profile: $error'),
        backgroundColor: Colors.red,
      ),
    );
  }
 }
}


  // Future<void> userProfile(context) async {
  //   final res = await http.patch(
  //     Uri.parse(updateProfile),
  //   );
  //   if (res.statusCode == 200) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => AccountPage()));

  //     print(res.body);
  //     final Map<String, dynamic> responseData = json.decode(res.body);
  //     print(responseData['token']);
  //   } else {
  //     throw Exception("Failed to update profile");
  //   }
  // 