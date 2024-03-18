import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

 final nameControllerr = TextEditingController();
    final emailControllerr = TextEditingController();
    final passwordControllerr = TextEditingController();

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}


String role = "";
String avatar = "";

List<Map<dynamic, dynamic>> studentsList = [];


class _StudentListPageState extends State<StudentListPage> {
  List<Student> students = [
    Student(
      id: 1,
      name: 'John Doe',
      email: 'johndoe@example.com',
      password: 'password123',
      isAdmin: false,
    ),
    Student(
      id: 2,
      name: 'Jane Smith',
      email: 'janesmith@example.com',
      password: 'password456',
      isAdmin: true,
    ),
  ];

  Future<void> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final userId = prefs.getInt('id');

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
          studentsList = List<Map<String, dynamic>>.from(ProfileData['data']);
          nameControllerr.text = ProfileData['data']['name'] ?? '';
          nameControllerr.text = ProfileData['data']['email'] ?? '';
          passwordControllerr.text=ProfileData['data']['password']?? '';
          role = ProfileData['data']['role'] ?? '';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              leading: GestureDetector(
                onTap: () {
                  _showProfilePicture(context, student.name);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    student.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                student.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ListTile(
                  title: Text('Email: ${student.email}'),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Role: ${student.isAdmin ? 'Admin' : 'User'}'),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          _showRoleEditDialog(student);
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Edit Student'),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          _showStudentEditDialog(student);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showProfilePicture(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 60,
                  child: Text(
                    name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStudentEditDialog(Student student) {
   

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Student Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameControllerr,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: emailControllerr,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordControllerr,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  student.name = nameControllerr.text;
                  student.email = emailControllerr.text;
                  student.password = passwordControllerr.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showRoleEditDialog(Student student) {
    final roleOptions = ['User', 'Admin'];
    String selectedRole = student.isAdmin ? 'Admin' : 'User';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Role'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: roleOptions.map((role) {
                  return RadioListTile(
                    title: Text(role),
                    value: role,
                    groupValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  student.isAdmin = selectedRole == 'Admin';
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

class Student {
  final int id;
  String name;
  String email;
  String password;
  bool isAdmin;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isAdmin,
  });
}
