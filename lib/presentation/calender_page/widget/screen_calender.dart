import 'package:flutter/material.dart';



class ScreenCaleneder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu in Container'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Container Content',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'option1',
                      child: Text('Option 1'),
                    ),
                    PopupMenuItem(
                      value: 'option2',
                      child: Text('Option 2'),
                    ),
                    PopupMenuItem(
                      value: 'option3',
                      child: Text('Option 3'),
                    ),
                  ];
                },
                onSelected: (value) {
                  // Handle menu item selection
                  print('Selected: $value');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Open Menu',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
