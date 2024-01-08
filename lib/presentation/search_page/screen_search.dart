import 'package:flutter/material.dart';


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



class ScreenSrearch extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScreenSrearch> {
  final List<Event> events = [
    Event(
      name: 'Flutter Workshop',
      date: '2024-01-15',
      location: 'City Hall',
      imageUrl: 'https://www.example.com/images/flutter_workshop_image.jpg',
    ),
    Event(
      name: 'Networking Event',
      date: '2024-01-20',
      location: 'Conference Center',
      imageUrl: 'https://www.example.com/images/networking_event_image.jpg',
    ),
    Event(
      name: 'Mobile App Summit',
      date: '2024-01-25',
      location: 'Exhibition Hall',
      imageUrl: 'https://www.example.com/images/app_summit_image.jpg',
    ),
  ];

  final List<Event> comingSoonEvents = [
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
            colors: [Colors.blue.shade50, Colors.blue.shade100],
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
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Expanded(
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
              child:const  Text(
                'Coming Soon:',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Expanded(
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
                                event: comingSoonEvents[index]),
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
           const  SizedBox(height: 16),
           const Text (
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          const SizedBox(height: 8),
          const Text(
              'Add your event description here...', // Replace with the actual description
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
