

import 'package:flutter/material.dart';


class EventDayContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    child:  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
          'Event Title',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Date: January 15, 2024',
          style: TextStyle(fontSize: 16),
        ),
        
        SizedBox(height: 20),
        Text(
          'Description:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Text(
          'Agenda:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: EventAgendaListView(),
        ),
         SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.blue, // Customize the color as needed
              child: Center(
                child: Text(
                  'This is another section.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    ),
          );
    
  }
}

class EventAgendaListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50, // Change this to the number of agenda items
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('Agenda Item $index'),
            subtitle: Text('Details about Agenda Item $index'),
            // Add more customization as needed
          ),
        );
      },
    );
  }
}

