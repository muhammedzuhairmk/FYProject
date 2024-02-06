// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/account_page/pickProfile.dart';

import 'profile.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<AccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController admissionNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



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
            const pickProfile(),
            const SizedBox(height: 5),


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


            Center(
              child: Container(
                height:400,
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
                        width: 200,
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
                           SizedBox(width: 20,),
                           Text( "suhair"),
                        ],
                      ),
                      ),
                
                      const SizedBox(height: 10),
                
                     Container(
                        height: 50,
                        width: 200,
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
                
                      const SizedBox(height: 10),
                      
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
                
                      const SizedBox(height: 10),
                
                     Container(
                        height: 50,
                        width: 200,
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
                      
                      const SizedBox(height: 10),
                
                     Container(
                        height: 50,
                        width: 200,
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
                      
                      const SizedBox(height: 10),
                
                     Container(
                        height: 50,
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const  Row(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.lock),
                          ),
                           Text( "7510382986"),
                        ],
                      ),),
                  
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



