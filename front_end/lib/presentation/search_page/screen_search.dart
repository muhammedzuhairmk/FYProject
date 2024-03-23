// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  DateTime selectedDate = DateTime.now();
 
 List<Map<dynamic, dynamic>> presentEvents = [];
 List<Map<dynamic, dynamic>> singleEvents = [];
  

String formateda(String tmpD,String tmpL){
DateTime dt = DateTime.parse(tmpD);
final formattedDate = DateFormat('dd-MM-yyyy').format(dt);
//final formattedTime = DateFormat('HH:mm').format(dt);
String loc=tmpL;
return 'Date :$formattedDate\nLocation :$loc';
}


var Search=null;

Future<void> fecthEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
  //  final userId = prefs.getInt('id');

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






   Future<void> fecthPresentEventList() async {
     final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    presentEvents=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
   // final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse('$admineventview?title=$Search&date=$formattedDate'),
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
          Search=null;
                                  
        });
      Search="";
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

 
    fecthEventList();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All events'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:const  EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.keyboard),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Search an event',
                            ),
                          ),
                        ),
                        IconButton(
                          icon:const  Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                               Search=searchController.text;
                            });
                           if(searchController.text.isNotEmpty){
                            print(Search);

 fecthPresentEventList();
 
                           }
                           else if(searchController.text.isEmpty){
                            presentEvents=[];
                           }
                           
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(width: 8.0),
                // IconButton(
                //   icon:const  Icon(Icons.calendar_today),
                //   onPressed: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       firstDate: DateTime(2020),
                //       lastDate: DateTime(2030),
                //     );

                //     if (pickedDate != null && pickedDate != selectedDate) {
                //       setState(() {
                //         selectedDate = pickedDate;
                //         print('Selected Date: $selectedDate');
                //         formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                     
                //       });
                //     }
                //   },
                // ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Text('Events on ${selectedDate.toLocal()}'),

           Expanded(
              flex: 1,
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
        ],
      ),
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
        ),)
      ),
    );
  }
}
