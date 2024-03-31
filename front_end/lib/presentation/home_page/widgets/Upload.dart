import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:front_end/core/constant/routes.dart';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uploadImage extends StatefulWidget {
  const uploadImage({super.key});

  @override
  State<uploadImage> createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  List<Map<dynamic, dynamic>> presentEvents = [];

  void fecthPresentEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(presenteventList),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          presentEvents = List<Map<String, dynamic>>.from(responseData['data']);
        });

        print('Response Body: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsms. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }

  String formateda(String tmpD, String tmpL) {
    DateTime dt = DateTime.parse(tmpD);
    final formattedDate = DateFormat('dd-MM-yyyy').format(dt);
//final formattedTime = DateFormat('HH:mm').format(dt);
    String loc = tmpL;
    return 'Date :$formattedDate\nLocation :$loc';
  }

  @override
  void initState() {
    super.initState();

    fecthPresentEventList();

    print("evetn page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Events',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: presentEvents.isEmpty
            ? const Center(child: Text("no  events"))
            : ListView.builder(
                itemCount: presentEvents.length,
                itemBuilder: (context, index) {
                  final item = presentEvents[index];

                  print(item['image']);
                  print("image url");
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          "${ImageUrl}${item['thumbnail']['image']}",

                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                      title: Text(
                        '${item['title']}',
                      ),
                      subtitle: Text(
                          formateda(item['eventDate'], item['location'])
                          //'Date: ${item['eventDate']}\nLocation: ${item['location']}',
                          ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleUpload(
                                    id: item['_id'],
                                    title: item['title'],
                                    urll: item['thumbnail']['image'],
                                  )),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class SingleUpload extends StatefulWidget {
  final id;
  final title;
  final urll;

  const SingleUpload({
    super.key,
    required this.id,
    required this.title,
    required this.urll,
  });

  @override
  State<SingleUpload> createState() => _SingleUploadState();
}

Uint8List? _image;
File? selectedImage;
double? height=350;
double? width=double.infinity;
 List<Map<dynamic, dynamic>> presentEvents = [];

class _SingleUploadState extends State<SingleUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: GestureDetector(
                child: Container(
                    height: height,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15.0), // Set border radius here
                      child: !hasImage ?  Image.network(
                        ImageUrl + widget.urll,
                        fit: BoxFit.cover,
                      ) :   Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ) ,
                    )),
                    onTap: () {
                      setState(() {
                        height=null;
                        width=null;
                      });
                    },
                    onDoubleTap: () {
                       setState(() {
                        height=350;
                        width=double.infinity;
                      });
                    },
              ),
              // onTap: () {
              //   setState(() {
              //     height = null;
              //     width = null;
              //   });
              // },
              // onDoubleTap: () {
              //   setState(() {
              //     height = 250;
              //     width = double.infinity;
              //   });
              // },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15.0), // Set the radius here
                ),
                width: double.infinity,
                height: 80,
                child: Padding(
                    padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    color:
                                        const Color.fromARGB(255, 51, 99, 138),
                                    hoverColor:
                                        const Color.fromARGB(255, 78, 131, 175),
                                    icon: const Icon(Icons.camera),
                                    onPressed: () {
                                      _pickImageCamera();
                                    },
                                  ),
                                  const Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 51, 99, 138),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    color:
                                        const Color.fromARGB(255, 51, 99, 138),
                                    hoverColor:
                                        const Color.fromARGB(255, 78, 131, 175),
                                    icon: const Icon(Icons.upload),
                                    onPressed: () {
                                      _pickImage();
                                    },
                                  ),
                                  const Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 51, 99, 138),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ])),
              )),
          ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: const Text("Submit"))
       
       
       
       
       
        ],
      )),
    );
  }

Future<void> fecthPresentEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(presenteventList),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          presentEvents = List<Map<String, dynamic>>.from(responseData['data']);
          
                                  
        });
      
        print('Response Body: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsms. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }


bool hasImage = false;


  Future<void> _pickImage() async {

    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    

    setState(() {
      selectedImage = File(returnImage.path);
      hasImage = true;
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future<void> _pickImageCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
       hasImage = true;
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  Future<void> submitData() async {
    print("event here");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    try {
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse(addgallery + widget.id),
      )
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json'
        ..headers['Content-Type'] = 'multipart/form-data';

      if (selectedImage != null) {
        request.files.add(
          http.MultipartFile(
            'gallery',
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

        // ignore: use_build_context_synchronously
        CustomDialog.showDialogBox(
          context,
          'Successfully created',
          'Image added to gallery.',
        );
      } else {
        print("event here on not 201");

        // ignore: use_build_context_synchronously
        CustomDialog.showDialogBox(
          context,
          'Failed to Update',
          'Profile updating failed. Status: ${response.statusCode}',
        );
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
}
