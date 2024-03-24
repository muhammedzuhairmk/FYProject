import 'dart:convert';
import 'package:front_end/presentation/admin_page/singleview_approval.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AdminApprovalPage extends StatefulWidget {
  @override
  _AdminApprovalPageState createState() => _AdminApprovalPageState();
}

class _AdminApprovalPageState extends State<AdminApprovalPage> {
  List<Map<dynamic, dynamic>> presentEvents = [];
  List<Map<dynamic, dynamic>> singleEvents = [];

  void fecthPresentEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(viewevent),
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

  String formateda(String tmpD, String tmpL) {
    DateTime dt = DateTime.parse(tmpD);
    final formattedDate = DateFormat('dd-MM-yyyy').format(dt);
//final formattedTime = DateFormat('HH:mm').format(dt);
    String loc = tmpL;
    return 'Date :$formattedDate\nLocation :$loc';
  }

  @override
  void initState() {
    super.initState();

    fecthPresentEventList();

    print("evetn page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Approval',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: presentEvents.isEmpty
            ? const Center(child: Text("no  events"))
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
                          formateda(item['eventDate'], item['location'])
                          //'Date: ${item['eventDate']}\nLocation: ${item['location']}',
                          ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SingleViewApproval(eventid: item['_id'])),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
