// ignore_for_file: unnecessary_brace_in_string_interps, use_key_in_widget_constructors
import 'dart:convert';

import 'package:front_end/core/constant/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front_end/presentation/home_page/widgets/sliding_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {

List<Map<dynamic, dynamic>> presentEvents = [];
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


    print("evetn page");
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),


        SlidingImage(),


        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          child: const Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),


        Container(
          height: 250,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),


          child: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(15),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Heading',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                          ' As of my last knowledge update in January 2022, there isn  a universally recognized "World Computer Day." However, various countries and organizations may celebrate different days to acknowledge and commemorate the importance of computers and information technology.In general, the celebration of a World Computer Day could involve activities such as promoting digital literacy, organizing events to raise awareness about the significance of computers, and highlighting advancements in information technology that have contributed to societal progress.If there has been a recent global initiative or development related to World Computer Day since my last update, I recommend checking the latest sources for accurate and up-to-date information. Additionally, different countries or organizations may have their own observances or events dedicated to recognizing the role of computers in our lives.'),
                    ],
                  )),
            ],
          ),
        ),


        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
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
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),


          child: ListView(
            children: [
              Container(
                height: 40,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white, // Use the correct color
                    ),
                  ],
                ),
                child: const Text(
                  'Today Event Images',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),


              
                 Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  height: 150,
                  child: presentEvents.isEmpty?
                  const Center(child: Text("no present events"))
                  :ListView.builder(
                    scrollDirection: Axis.horizontal,
                     itemCount: presentEvents.length,
                        itemBuilder: (context, index) {
                           final item = presentEvents[index];
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(8),
                          color: Colors.black26,
                          width: 200,
                          child: Image.network(
                                    "${ImageUrl}${item['thumbnail']['image']}",
                                    fit: BoxFit.cover,),
                                   
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
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white, // Use the correct color
                    ),
                  ],
                ),
                child: const Text(
                  'Coming Events',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),


              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                height: 150,
                child:commingEvents.isEmpty?
                const Center(child: Text("no Comming events"))
                 :ListView.builder(
                  scrollDirection: Axis.horizontal,
                   itemCount: commingEvents.length,
                      itemBuilder: (context, index) {
                         final item = commingEvents[index];
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8),
                        color: Colors.black26,
                        width: 200,
                        child: Image.network(
                                  "${ImageUrl}${item['thumbnail']['image']}",
                                  fit: BoxFit.cover,),
                                 
                      ),
                       onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventDetailsScreen(singleEvent: item,),
                                ),
                              );
                       }
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
class EventDetailsScreen extends StatelessWidget {
  
   Map<dynamic,dynamic> singleEvent;

  EventDetailsScreen({required this.singleEvent});

  
  @override
  Widget build(BuildContext context) {
    print(singleEvent['thumbnail']['image']);
    String imageUrl = ImageUrl + singleEvent['thumbnail']['image'] ;
    return Scaffold(
      appBar: AppBar(
        title: Text(singleEvent['title'], // Displaying title as text
              style: const TextStyle(fontSize: 26, color: Colors.black),),
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
                    imageUrl,
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
             singleEvent['title'], // Displaying title as text
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}