import 'dart:convert';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SingleViewApproval extends StatefulWidget {
  final eventid;
  const SingleViewApproval({super.key, required this.eventid});

  @override
  State<SingleViewApproval> createState() => _SingleViewApprovalState();
}

class _SingleViewApprovalState extends State<SingleViewApproval> {
  String title = "";
  String loc = "";
  String desc = "";
  String date = "";
  String Uname = "";
  String Uaddyear = "";
  String avatr = "";
  String thumbnail = "";
  double? height = 250;
  double? width = double.infinity;
String formattedDate="";
  Future<void> fecthEventList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    //final userId = prefs.getInt('id');

    print("i a here on fetch");
    try {
      print("i a here on fetch try");
      final response = await http.get(
        Uri.parse(getEventList + widget.eventid),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('gallery: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          title = responseData['data']['title'].toString();
          desc = responseData['data']['description'].toString();
          loc = responseData['data']['location'].toString();
          Uname = responseData['data']['user']['name'].toString();
          date = responseData['data']['eventDate'].toString();
          Uaddyear = responseData['data']['user']['admissionYear'].toString();
          thumbnail = responseData['data']['thumbnail']['image'] ?? '';
            DateTime dt = DateTime.parse(date);
formattedDate = DateFormat('dd-MM-yyyy').format(dt);
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


void approvEevent()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
final response = await http.patch(
        Uri.parse(aproveEvent+ widget.eventid),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
        if (response.statusCode == 200){
        print("successfully approved");
 // ignore: use_build_context_synchronously
 CustomDialog.showDialogBox(
        context,
        'successfully approved',
        'successfully approved',
      );
        }
        else{
          print("something went wrong");
        }
    }catch (e){
  print('Error fetching present gallery itsms: $e');
    }
} 
void rejectEevent()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
final response = await http.delete(
        Uri.parse(rejectEvent+ widget.eventid),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
        if (response.statusCode == 200){
        print("successfully approved");
 // ignore: use_build_context_synchronously
 CustomDialog.showDialogBox(
        context,
        'successfully Event Rejected',
        'successfully Event Rejected',
      );
      
        
       
        }
        else{
          print("something went wrong");
        }
    }catch (e){
  print('Error fetching present gallery itsms: $e');
    }
} 

  @override
  void initState() {
    super.initState();

    fecthEventList();

    print("evetn page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title, // Displaying title as text
          style: const TextStyle(fontSize: 26, color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Container(
                  height: height,
                  width: width,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set border radius here
                    child: Image.network(
                      ImageUrl + thumbnail,
                      fit: BoxFit.cover,
                    ),
                  )),
              onTap: () {
                setState(() {
                  height = null;
                  width = null;
                });
              },
              onDoubleTap: () {
                setState(() {
                  height = 250;
                  width = double.infinity;
                });
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15.0), // Set the radius here
                ),
                width: double.infinity,
                child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    
                      Text(desc),
                      //  const Text(" "),
                      // const Text("Location ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),
                      // const Text(" "),
                      // const Text("Date ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),

                    ])),
              )),
               Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15.0), // Set the radius here
                ),
                width: double.infinity,
                child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    
                      Text(desc),
                      const Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    
                      Text(formattedDate),
                      //  const Text(" "),
                      // const Text("Location ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),
                      // const Text(" "),
                      // const Text("Date ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),

                    ])),
              )),
               Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15.0), // Set the radius here
                ),
                width: double.infinity,
                child:  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text(
                        "Uploaded by",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    
                      Text(Uname),
                      //  const Text(" "),
                      // const Text("Location ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),
                      // const Text(" "),
                      // const Text("Date ", style: TextStyle(fontWeight: FontWeight.bold),),
                      // Text(loc),
                       const Text(
                        "Admission Year",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        
                      ),Text(Uaddyear),
                    ])),
              )),
  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
   Padding(padding :EdgeInsets.only(right: 10,left: 30,bottom: 10,top: 10),
     child: IconButton(onPressed: (){
     approvEevent();
     }, icon: Icon(Icons.check),style:IconButton.styleFrom(backgroundColor: Colors.green),),
   ),
    Padding(padding :EdgeInsets.only(right: 30,left: 10,bottom: 10,top: 10),
     child: IconButton(onPressed: (){
     rejectEevent();
    
     }, icon: Icon(Icons.close),style:IconButton.styleFrom(backgroundColor: Colors.red),),
   )
    ],
 )
        ]),
      ),
    );
  }
}
