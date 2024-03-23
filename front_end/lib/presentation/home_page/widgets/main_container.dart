// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:front_end/core/constant/routes.dart';
import 'package:front_end/presentation/home_page/widgets/sliding_image.dart';

class Event {
  final int id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      location: json['location'],
      imageUrl: json['imageUrl'],
    );
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  List<Map<dynamic, dynamic>> presentEvents= [];
  List<Map<dynamic, dynamic>> commingEvents = [];

   Future<void> fecthPresentEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(presenteventList),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          presentEvents = List<Map<String, dynamic>>.from(responseData['data']);
          
                                  
        });
      
        print('Response Body: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsms. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }


  Future<void> fecthCommingEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
   // final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(commingeventList),
        headers: <String, String>{
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          commingEvents = List<Map<String, dynamic>>.from(responseData['data']);
          
           
        });
        

    
          
        print('Response Body: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsms. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }

  @override
  void initState() {
    super.initState();
     fecthPresentEventList();
    fecthCommingEventList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),

        SlidingImage(),

        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.white)],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: 250,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.white)],
            ),
            child: presentEvents.isEmpty
                ? const Center(child: Text("No present events"))
                : ListView.builder(
                    itemCount: presentEvents.length,
                    itemBuilder: (context, index) {
                      final data = presentEvents[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${data['title']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('${data['description']}'
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.white)],
          ),
          child: const Text(
            'Albums',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 500,
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.white)],
          ),
          child: ListView(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.white)],
                ),
                child: const Text(
                  'Today Event Images',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                height: 150,
                child: presentEvents.isEmpty
                    ? const Center(child: Text("No present events"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                      itemCount: presentEvents.length,
                        itemBuilder: (context, index) {
                          final item = presentEvents[index];
                          return GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              //color: Colors.black26,
                              width: 200,
                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(
                                "${ImageUrl}${item['thumbnail']['image']}",) ,
                                 fit: BoxFit.cover,
                              ),),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsScreen(singleEvent: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.white)],
                ),
                child: const Text(
                  'Coming Events',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                height: 150,
                child: commingEvents.isEmpty
                    ? const Center(child: Text("No Coming events"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: commingEvents.length,
                        itemBuilder: (context, index) {
                          final item = commingEvents[index];
                          return GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                             // color: Colors.black26,
                              width: 200,
                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(
                                "${ImageUrl}${item['thumbnail']['image']}",) ,
                                 fit: BoxFit.cover,
                              ),),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventDetailsScreen(singleEvent: item),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class EventDetailsScreen extends StatefulWidget {
  
   Map<dynamic,dynamic> singleEvent;

  EventDetailsScreen({required this.singleEvent});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
String format(String date){
 DateTime dt = DateTime.parse(date);
final formattedDate = DateFormat('dd-MM-yyyy').format(dt);
return formattedDate;
}

double? height=250;

double? width=double.infinity;

  @override
  Widget build(BuildContext context) {
    print(widget.singleEvent['thumbnail']['image']);
    String imageUrl = ImageUrl + widget.singleEvent['thumbnail']['image'] ;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.singleEvent['title'], // Displaying title as text
              style: const TextStyle(fontSize: 26, color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
               
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade900],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  
                    child: GestureDetector(
                      child: Container(
                        width:width ,
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                            borderRadius:
                        BorderRadius.circular(15.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),onTap: () {
                        setState(() {
                          width=null;
                          height=null;
                        });
                      },onDoubleTap: () {
                         setState(() {
                          width=double.infinity;
                          height=250;
                        });
                      },
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
             
              Text(widget.singleEvent['description']
               , // Displaying title as text
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(height: 10,),  const Text(
                'Event Location:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
             
              Text(widget.singleEvent['location']
               , // Displaying title as text
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ), SizedBox(height: 10,),
               const Text(
                'Event Date:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              
              Text(format(widget.singleEvent['eventDate'])
               , // Displaying title as text
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

