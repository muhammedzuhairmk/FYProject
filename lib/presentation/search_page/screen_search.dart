import 'package:flutter/material.dart';



class ScreenSrearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
    );
  }
}
