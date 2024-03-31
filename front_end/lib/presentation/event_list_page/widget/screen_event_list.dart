// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_local_variable, avoid_print, non_constant_identifier_names, unnecessary_null_in_if_null_operators, prefer_final_fields, use_build_context_synchronously, must_be_immutable

import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:front_end/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'package:front_end/presentation/event_list_page/addEvent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';

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

class ScreenEventList extends StatefulWidget {
  final int? id;

  const ScreenEventList({
    this.id,
    super.key,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ScreenEventList> {
  bool isLoading = true;



  List<Map<dynamic, dynamic>> presentEvents = [];
  List<Map<dynamic, dynamic>> commingEvents = [];
 List<Map<dynamic, dynamic>> singleEvents = [];
  



  Future<void> fecthPresentEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

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
    final userId = prefs.getInt('id');

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

 Future<void> fecthEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(getEventList),
        headers: <String, String>{
           'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          singleEvents = List<Map<String, dynamic>>.from(responseData['data']);
        });
        print('Response Bodyyytttttttttttttt: ${response.body}');
      } else {
        print(
            'Failed to fetch present gallery itsmss. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching present gallery itsms: $error');
    }
  }


String formateda(String tmpD,String tmpL){
DateTime dt = DateTime.parse(tmpD);
final formattedDate = DateFormat('dd-MM-yyyy').format(dt);
final formattedTime = DateFormat('HH:mm').format(dt);
String loc=tmpL;
return 'Date :$formattedDate\nLocation :$loc';
}


  @override
  void initState() {
    super.initState();

    fecthPresentEventList();
    fecthCommingEventList();
    fecthEventList();

    print("evetn page");
  }

  

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
              flex: 2,
              child: presentEvents.isEmpty
                  ? const Center(child: Text("no present events"))
                  : ListView.builder(
                      itemCount: presentEvents.length,
                      itemBuilder: (context, index) {
                        final item = presentEvents[index];
                        print(item['image']);
                        print("image url");
                        return Card(
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              
                              child: Image.network(
                                "${ImageUrl}${item['thumbnail']['image']}",
                                
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                            title: Text(
                              '${item['title']}',
                            ),
                            subtitle: Text(
formateda(item['eventDate'],item['location'])
                              //'Date: ${item['eventDate']}\nLocation: ${item['location']}',
                            ),
                            onTap: () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventDetailsScreen(singleEvent: item),
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

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>  AddEvent(titl:"Add Event",id: "hhh",)));
                              
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child:  commingEvents.isEmpty
                  ? const Center(child: Text("no Comming events"))
                  : ListView.builder(
                      itemCount: commingEvents.length,
                      itemBuilder: (context, index) {
                        final item = commingEvents[index];
                        print(item['image']);
                        print("image url");
                  return Card(
                    child: ListTile(
                      leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              
                              child: Image.network(
                                "${ImageUrl}${item['thumbnail']['image']}",
                                
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                            title: Text(
                              '${item['title']}',
                            ),
                            subtitle: Text(
                              formateda(item['eventDate'],item['location'])
                            //'Date: ${item['eventDate']}\nLocation: ${item['location']}',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventDetailsScreen(singleEvent: item,),
                                      
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
              style: const TextStyle(fontSize: 26, color: Colors.black),),actions: [IconButton(onPressed: (){
Navigator.push(context,MaterialPageRoute(builder: ((context) => AddEvent(titl: "Edit Event", id: widget.singleEvent['_id']))));

              }, icon: const Icon(Icons.edit))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             Center(
                  
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
            ),
             SizedBox(height: 10,),
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
      ),)
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
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
