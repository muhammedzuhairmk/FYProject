// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Event {
  final String name;
  final String date;
  final String location;
  final String imageUrl;

  Event({
    required this.name,
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
      name: 'Flutter Workshop',
      date: '2024-01-15',
      location: 'City Hall',
      imageUrl: 'https://www.example.com/images/flutter_workshop_image.jpg',
    ),
    
  ];

  List<Event> comingSoonEvents = [
    Event(
      name: 'Future Event 1',
      date: '2024-02-01',
      location: 'TBD',
      imageUrl: 'https://www.example.com/images/future_event_1_image.jpg',
    ),
    Event(
      name: 'Future Event 2',
      date: '2024-02-15',
      location: 'TBD',
      imageUrl: 'https://www.example.com/images/future_event_2_image.jpg',
    ),
    Event(
      name: 'Future Event 3',
      date: '2024-02-01',
      location: 'TBD',
      imageUrl: 'https://www.example.com/images/future_event_1_image.jpg',
    ),
    Event(
      name: 'Future Event 4',
      date: '2024-02-15',
      location: 'TBD',
      imageUrl: 'https://www.example.com/images/future_event_2_image.jpg',
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
                      title: Text(events[index].name),
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
                      showDialog(
                        context: context,
                        builder: (context) => AddEventDialog(),
                      );
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
                      title: Text(comingSoonEvents[index].name),
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
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _descriptionController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _dateController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
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
      ),     child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.cover)
                  : const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              labelText: 'Title',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              hintText: 'Date',
              labelText: 'Date',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Description',
              labelText: 'Description',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your logic to save the event here
                  Event newEvent = Event(
                    name: _titleController.text,
                    date: _dateController.text,
                    location: 'TBD',
                    imageUrl: _selectedImage != null
                        ? _selectedImage!.path
                        : 'https://www.example.com/images/default_image.jpg',
                  );
                  setState(() {
                    // ignore: prefer_typing_uninitialized_variables
                    var comingSoonEvents;
                    comingSoonEvents.add(newEvent);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
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
        title: Text(event.name),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              event.imageUrl, // Displaying description as text
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
