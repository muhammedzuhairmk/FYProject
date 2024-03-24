// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:front_end/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<dynamic, dynamic>> getEventList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool visi = false;
  Future<void> addnotification(String t, String d) async {
    print("Here comes");
    try {
      print("Here comesd");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(createnotification),
        headers: <String, String>{
          'Accept': "application/json",
          'Authorization': 'Bearer $token',
        },
        body: {
          "title": t,
          "description": d,
        },
      );

      if (response.statusCode == 201) {
        print("Here comessssssssss");
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        print('added!');

        getnotification();
        // Extract any additional information you may need from the response
      } else {
        print("errrors comes");
        print('Error : ${response.statusCode}');
        // Handle signup errors here
        // You might want to throw an exception or return an error message
      }
    } catch (e) {
      print("errrors comessssdddd");
      print('Error aaaaaaadd: $e');
      // Handle signup errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }

  Future<void> getnotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var role = prefs.getString("role");
    if (role == "admin") {
      setState(() {
        visi = true;
      });
    }
    print("Here comes");
    try {
      print("Here comesd");

      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(getNotification),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Here comessssssssss");
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          getEventList = List<Map<String, dynamic>>.from(responseData['data']);
        });

        print(responseData);
        print('added!');
      } else {
        print("errrors comes");
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print("errrors comessssdddd");
      print('Error aaaaaaadd: $e');
      // Handle signup errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }

  void seen(var id) async {
    try {
      print("Here comesd");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.patch(
        Uri.parse(seenNotf + id),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Here comessssssssss");
      } else {
        print("errrors comes");
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print("errrors comessssdddd");
      print('Error aaaaaaadd: $e');
      // Handle signup errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }

  String title(Map<dynamic, dynamic> notf) {
    final id = notf['_id'];
    seen(id);
    String str = notf['title'];
    return str;
  }

  @override
  void initState() {
    super.initState();
    getnotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: getEventList.length,
        itemBuilder: (context, index) {
          final notification = getEventList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              title: Text(
                (title(notification)),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Text('${notification['description']}'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: visi,
                      child: ElevatedButton(
                        onPressed: () {
                          _deleteNotification('${notification['_id']}');
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Visibility(
        visible: visi,
        child: FloatingActionButton(
          onPressed: () {
            _showAddNotificationDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // _addNotification(titleController.text, contentController.text);
                addnotification(titleController.text, contentController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // void _addNotification(String title, String content) {
  //   int id = getEventList.isNotEmpty ? getEventList.last.id + 1 : 1;
  //   NotificationItem newNotification = NotificationItem(
  //     id: id,
  //     title: title,
  //     content: content,
  //   );
  //   setState(() {
  //     getEventList.add(newNotification);
  //   });
  // }

  void _deleteNotification(String id) async {
    print("Here comes");
    try {
      print("Here comesd");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.delete(
        Uri.parse(deleteNotification + id),
        headers: <String, String>{
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Here comessssssssss");
        final Map<String, dynamic> responseData = json.decode(response.body);

        print(responseData);
        print('addedffff!');
        getnotification();
      } else {
        print("errrors comes");
        print(id);
        print('Error : ${response.statusCode}');
      }
    } catch (e) {
      print("errrors comessssdddd");
      print('Error aaaaaaadd: $e');
      // Handle signup errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }
}
