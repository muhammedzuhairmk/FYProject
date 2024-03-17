// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, file_names


import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget/screen_event_list.dart';

class AddEvent extends StatefulWidget {
  final int? id;

  const AddEvent({
    this.id,
    super.key,
  });

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();

  String avatar = "";

DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedtime;
  String date = "Enter date";
  String time = "enter time";
  var t1 = null;
  var t2 = null;


  Future<void> submitData() async {
    print("event here");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

    try {
    print("event here on try");
    print(DateTime.now().toString());
    print('$date$time:00.000000');
      if (_formKey.currentState?.validate() ?? false) {
    
        setState(() {
          isLoading = true;
        });
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(eventList),
        )
          ..headers['Authorization'] = 'Bearer $token'
          ..headers['Accept'] = 'application/json'
          ..headers['Content-Type'] = 'multipart/form-data'
          ..fields['title'] = title.text
          ..fields['eventDate'] = '$date$time:00.000000'//"2024-03-05 20:46:47.139673"
          ..fields['location'] = location.text
          ..fields['description'] = description.text;
        

        if (selectedImage != null) {
          request.files.add(
            http.MultipartFile(
              'image',
              http.ByteStream.fromBytes(_image!),
              _image!.length,
              filename: 'images.jpg',
            ),
          );
        }

        final response = await request.send();
        final responseData = await response.stream.bytesToString();

        print('Response Body: $responseData');

        if (response.statusCode == 201) {
        print("event here on 200");
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
        print("event here on not 201");
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
    print("event here on catch");
      CustomDialog.showDialogBox(
        context,
        'Network Error!',
        'Check your connection!',
      );
    }
  }

 bool isLoading = false;

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
                      "Add Event",
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
                                       ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            height: 300.0,
                                            width: 300.0,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: MemoryImage(_image!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : (avatar.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                height: 300.0,
                                                width: 300.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        url + avatar),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                height: 300.0,
                                                width: 300.0,
                                                decoration:const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/user.jpg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  // ? CircleAvatar(
                                  //     radius: 100,
                                  //     backgroundImage: MemoryImage(_image!),
                                  //   )
                                  // : (avatar.isNotEmpty
                                  //     ? CircleAvatar(
                                  //         radius: 100,
                                  //         backgroundImage:
                                  //             NetworkImage(url + avatar),
                                  //       )
                                  //     : const CircleAvatar(
                                  //         radius: 100,
                                  //         backgroundImage: AssetImage(
                                  //             'assets/images/user.jpg'),
                                  //       )),
                                  Positioned(
                                    bottom: 0,
                                    
                                    child: SizedBox(height: 30,width: 300,
                                      child: TextButton(
                                        onPressed: () {
                                          _pickImage();
                                        },style: TextButton.styleFrom(backgroundColor: Colors.white,foregroundColor: Colors.black),
                                       // icon: const Icon(Icons.add_a_photo),
                                       child:const Text("Upload Image",style: TextStyle(fontWeight:FontWeight.bold),),
                                       
                                      ),
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
                                return 'Enter The Event Title';
                              }
                              return null;
                            },
                            autofillHints:Characters("string"),
                            controller: title,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Event Title",
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
                                return 'Enter The place Of Event';
                              }
                              return null;
                            },
                            readOnly: false,
                            controller: location,
                            decoration: InputDecoration(
                              hintText: "Event location",
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
                                return 'Enter The Description';
                              }
                              return null;
                            },
                            maxLines: 3,
                            readOnly: false,
                            controller: description,
                            decoration: InputDecoration(
                              hintText: "Description",
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 1),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2030),
                                      );

                                      if (pickedDate != null &&
                                          pickedDate != selectedDate) {
                                        setState(() {
                                          selectedDate = pickedDate;

                                          date =
                                              '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}';
                                          t1 = date;
                                        });
                                        print(date);
                                      }
                                    },
                                    child: Text(date),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () async {
                                    final TimeOfDay? newTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (newTime != null) {
                                      setState(() {
                                        selectedtime = newTime;

                                        print('selected time $selectedtime');

                                        time =
                                            ' ${selectedtime.hour.toString().padLeft(2, '0')}:${selectedtime.minute.toString().padLeft(2, '0')}';
                                        print(time);
                                        
                                        t2 = time;
                                      });
                                    }
                                  },
                                  child: Text(time),
                                ),
                              ]),
                          const SizedBox(height: 10),
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
                                            color: const Color.fromARGB(
                                                255, 56, 105, 148)),
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
