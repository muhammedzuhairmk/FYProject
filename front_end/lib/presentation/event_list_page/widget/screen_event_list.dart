// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_local_variable, avoid_print, non_constant_identifier_names, unnecessary_null_in_if_null_operators, prefer_final_fields, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:front_end/presentation/event_list_page/addEvent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/routes.dart';

class Event {
  final String title;
  final String date;
  final String location;
  final String imageUrl;

  Event({
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });
}

class ScreenEventList extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScreenEventList> {
  List<Event> events = [
    Event(
      title: 'Flutter Workshop',
      date: '2024-01-15',
      location: 'City Hall',
      imageUrl:
          'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
    ),
  ];

  List<Event> comingSoonEvents = [
    Event(
      title: 'Future Event 1',
      date: '2024-02-01',
      location: 'TBD',
      imageUrl:
          'https://img.freepik.com/premium-photo/advance-cyberspace-concept_862994-20265.jpg?size=626&ext=jpg&ga=GA1.1.1315563093.1704684554&semt=ais',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Present Events:',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.network(
                            events[index].imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(events[index].title),
                      subtitle: Text(
                        'Date: ${events[index].date}\nLocation: ${events[index].location}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EventDetailsScreen(event: events[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Coming Soon:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (
                      //context) => AddEventDialog(),
                      // );

                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => AddEvent()));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: comingSoonEvents.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Image.network(
                            comingSoonEvents[index].imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(comingSoonEvents[index].title),
                      subtitle: Text(
                        'Date: ${comingSoonEvents[index].date}\nLocation: ${comingSoonEvents[index].location}',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(
                              event: comingSoonEvents[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddEventDialog extends StatefulWidget {
  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool isLoading = false;

  Future<void> fetchEvent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

    try {
      final response = await http.get(
        Uri.parse(getEventList),
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
          _titleController.text = ProfileData['data']['title'].toString();
          _descriptionController.text =
              ProfileData['data']['description'].toString();
          _locationController.text = ProfileData['data']['location'].toString();
          _dateController.text = ProfileData['data']['eventDate'].toString();

          // _selectedImage = File(ProfileData['data']['avatar']) ?? null;
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

    fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: null,
              child: Form(
                key: _formKey,
                child: Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: const Icon(Icons.add_a_photo,
                      size: 40, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Title';
                }
                return null;
              },
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Title",
                // icon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.transparent, // Set the border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:
                        Colors.transparent, // Set the border color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // TextFormField(
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter Date';
            //     }
            //     return null;
            //   },
            //   controller: _datecontroller,
            //   decoration: InputDecoration(
            //     hintText: "Date",
            //     // icon: const Icon(Icons.person),
            //     filled: true,
            //     fillColor: Colors.white,
            //     contentPadding: const EdgeInsets.all(15),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15),
            //       borderSide: const BorderSide(
            //         color: Colors.transparent, // Set the border color
            //       ),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(15),
            //       borderSide: const BorderSide(
            //         color:
            //             Colors.transparent, // Set the border color when focused
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Place';
                }
                return null;
              },
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Place",
                // icon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.transparent, // Set the border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:
                        Colors.transparent, // Set the border color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Description';
                }
                return null;
              },
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                // icon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.transparent, // Set the border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color:
                        Colors.transparent, // Set the border color when focused
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 56, 105, 148),
                          ),
                          width: double.infinity,
                        ),
                      ),
                      TextButton(
                        onPressed: null,
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
                                style: TextStyle(color: Colors.white),
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
                            borderRadius: BorderRadius.circular(10),
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
    );
  }
}

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade900],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.network(
                    event.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              event.title, // Displaying title as text
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog {
  static void showDialogBox(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
