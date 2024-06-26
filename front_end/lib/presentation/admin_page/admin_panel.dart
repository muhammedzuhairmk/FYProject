// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/registration/registration_page.dart';

import '../home_page/widgets/Notification.dart';
import 'approval.dart';
import 'student_list.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           
          title: Container(
            margin:const EdgeInsets.symmetric(horizontal: 50),
            child:const Text(
                        'Eventsnap',
                        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
                        ),
                      ),
                     ),


           shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(350),
              ),
            ),
        ),


        body: ListView(
          children: [
          const  SizedBox(
              height: 100,
            ),
           const Center(
             child:  Text(
                'Admin Panel',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
           ),


            Container(
                height: 200,
                padding:const EdgeInsets.all(15),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                    ),
                  ],
                ),


                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  
                     Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            hoverColor: const Color.fromARGB(255, 78, 131, 175),
                            icon:const Icon(Icons.receipt_long),
                            onPressed: () {
                              Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => StudentListPage()),
                               );
                              // Handle camera icon press
                              print('Student List icon pressed');
                            },
                          ),


                         const Text(
                            'Students',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),



                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            hoverColor: const Color.fromARGB(255, 78, 131, 175),
                            icon:const Icon(Icons.notification_add_rounded),
                            onPressed: () {
                              Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => NotificationPage()),
                               );
                            }
                          ),


                         const Text(
                            'Notifica',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),



               const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            hoverColor:const  Color.fromARGB(255, 78, 131, 175),
                            icon:const  Icon(Icons.verified_outlined),
                            onPressed: () {
                              // Handle camera icon press
                              Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => AdminApprovalPage()),
                               );
                              print('verification icon pressed');
                            },
                          ),


                        const  Text(
                            'Approval',
                            style:  TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                     Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            hoverColor:const  Color.fromARGB(255, 78, 131, 175),
                            icon: const Icon(Icons.person_2),
                            onPressed: () {
                               Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => Reg_page()),
                               );
                              // Handle camera icon press
                              print('upload icon pressed');
                            },
                          ),
                         const  Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]
                ),
              ],
            ),
            ),


            const SizedBox(height: 35,),
             Column(
               children: [
                 Container(
                  margin:const  EdgeInsets.all(20),
                  padding:const  EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                   child:  const Image(image: AssetImage("assets/images/amalcollege.png"),width: 10.2,height: 10.0,),
                    decoration:const  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                       ),


                 Container(
                  height: 170,
                  width: 600,
                  decoration:const  BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(120),
                     ),


                  boxShadow:  [
                    BoxShadow(
                    color: Colors.white,
                    ),
                    ],
                    ),
                                 child:const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                    Text('Department of Computer Science',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                     Text('Amal College Of Advanced Studies In Nilambur'),
                                   ],
                                 )
                           ),
                      ],
                    ),
                  ]
                ) 
             );
         }
      }
