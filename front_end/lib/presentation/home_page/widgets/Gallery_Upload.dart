// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api, use_key_in_widget_constructors, file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculty Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FacultyListPage(),
    );
  }
}

class FacultyListPage extends StatefulWidget {
  @override
  _FacultyListPageState createState() => _FacultyListPageState();
}

class _FacultyListPageState extends State<FacultyListPage> {
  List<Faculty> faculties = [];

  @override
  void initState() {
    super.initState();
    fetchFaculties();
  }

  Future<void> fetchFaculties() async {
    final response = await http.get(Uri.parse('http://192.168.14.131:3000/faculties'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      setState(() {
        faculties = data.map((item) => Faculty.fromJson(item)).toList().cast<Faculty>();
      });
    } else {
      throw Exception('Failed to load faculties');
    }
  }

  Future<void> deleteFaculty(String id) async {
    final response = await http.delete(Uri.parse('http://192.168.14.131:3000/faculties/$id'));
    if (response.statusCode == 200) {
      fetchFaculties();
    } else {
      throw Exception('Failed to delete faculty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Management'),
      ),
      body: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: faculties[index].profileImage != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(faculties[index].profileImage!),
                  )
                : null,
            title: Text(faculties[index].name),
            subtitle: Text(faculties[index].designation),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteFaculty(faculties[index].id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFacultyPage()),
          ).then((value) => fetchFaculties());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddFacultyPage extends StatefulWidget {
  @override
  _AddFacultyPageState createState() => _AddFacultyPageState();
}

class _AddFacultyPageState extends State<AddFacultyPage> {
  late TextEditingController nameController;
  late TextEditingController educationController;
  late TextEditingController numberController;
  late TextEditingController designationController;

  File? _image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    educationController = TextEditingController();
    numberController = TextEditingController();
    designationController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    educationController.dispose();
    numberController.dispose();
    designationController.dispose();
    super.dispose();
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> addFaculty() async {
    final uri = Uri.parse('http://192.168.14.131:3000/faculties');
    final request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    request.fields['education'] = educationController.text;
    request.fields['designation'] = designationController.text;
    if (numberController.text.isNotEmpty) {
      request.fields['number'] = numberController.text;
    }
    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('profile_image', _image!.path));
    }

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      Navigator.pop(context); // Return to the faculty list page after adding the faculty
    } else {
      throw Exception('Failed to add faculty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Faculty'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(75),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 50,
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: educationController,
              decoration: const InputDecoration(
                labelText: 'Education',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: designationController,
              decoration: const InputDecoration(
                labelText: 'Designation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:() {
              addFaculty();
              },
              child: const Text('Add Faculty'),
            ),
          ],
        ),
      ),
    );
  }
}

class Faculty {
  final String id;
  final String name;
  final String education;
  final String? number;
  final String designation;
  final String? profileImage;

  Faculty({
    required this.id,
    required this.name,
    required this.education,
    this.number,
    required this.designation,
    this.profileImage,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      id: json['id'],
      name: json['name'],
      education: json['education'],
      number: json['number'],
      designation: json['designation'],
      profileImage: json['profile_image'],
    );
  }
}
