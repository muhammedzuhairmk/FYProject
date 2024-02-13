// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'profile.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<AccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController admissionNumberController = TextEditingController();
  

Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:  ListView(
          children: [
            
            const SizedBox(height: 5),

           
              Center(
        heightFactor: 1.2,
        child: Stack(
          children: [
            _image != null ? CircleAvatar( radius: 60, backgroundImage: MemoryImage(_image!))
                : const CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                  ),
          ]
          ),
              ),

Container(
  height: 50,
  margin: const EdgeInsets.symmetric(horizontal: 25),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
       const  Text(
          "Account Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
       const  SizedBox(width: 0),
        IconButton(
          hoverColor: const Color.fromARGB(255, 78, 131, 175),
          icon: const Icon(Icons.person_add),
          onPressed: () {
            // Navigate to the AccountPage using Navigator
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountProfilePage()),
            );
          },
        ),
      ],
    ),
  ),
),

const SizedBox(height: 10),

            Center(
              child: Container(
                height:380,
                width: 300,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                        height: 50,
                        width: 180,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                  
                      child:const  Row(
                        children: [
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10),
                             child: Icon(Icons.person),
                           ),
                           Text( "suhair"),
                        ],
                      ),
                      ),
                
                      const SizedBox(height: 14),
                
                     Container(
                        height: 50,
                        width: 250,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const  Row(
                        children: [
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal:10),
                             child: Icon(Icons.email_outlined),
                           ),
                           Text( "zuhairmk@gmail.com"),
                        ],
                      ),
                      ),
                
                      const SizedBox(height: 14),
                      
                     Container(
                        height: 50,
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                       decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),child:const  Row(
                        children: [
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10),
                             child: Icon(Icons.phone),
                           ),
                           Text( "7510382986"),
                        ],
                      ),),
                
                      const SizedBox(height: 14),
                
                     Container(
                        height: 50,
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const  Row(
                        children: [
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10),
                             child: Icon(Icons.calendar_today),
                           ),
                           Text( "2021"),
                        ],
                      ),),
                      
                      const SizedBox(height: 14),
                
                     Container(
                        height: 50,
                        width: 180,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const  Row(
                        children: [
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10),
                             child: Icon(Icons.confirmation_number),
                           ),
                           Text( "860601"),
                        ],
                      ),),
                      
                      const SizedBox(height: 14),
                
                     
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}




