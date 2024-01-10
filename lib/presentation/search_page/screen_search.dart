import 'package:flutter/material.dart';

<<<<<<< HEAD

=======
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();
>>>>>>> 2a32e55c94734a4e6a646cf68ff499370e74050e

class ScreenSrearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Flutter AppBar with Drawer Example'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text('Main Content'),
      ),
      
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Add your onTap action here
              Navigator.pop(context); // Closes the drawer
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Add your onTap action here
              Navigator.pop(context); // Closes the drawer
            },
          ),
          // Add more list items as needed
=======
        title: Text('All events'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search based on searchController.text
              // Add your search logic here
              print('Search: ${searchController.text}');
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate;
                  // Perform date-based filtering
                  // Add your filtering logic here
                  print('Selected Date: $selectedDate');
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search events',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    // Clear search results or update UI accordingly
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Events on ${selectedDate.toLocal()}'),
          // Display events based on the selected date
          // Add your event display logic here
>>>>>>> 2a32e55c94734a4e6a646cf68ff499370e74050e
        ],
      ),
    );
  }
}
