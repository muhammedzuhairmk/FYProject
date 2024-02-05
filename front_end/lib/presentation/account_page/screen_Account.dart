// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/account_page/pickProfile.dart';



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
        padding: const EdgeInsets.all(16.0),
        child:  ListView(
          children: [
            const pickProfile(),
            const SizedBox(height: 20),

            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Center(
                child: Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                height:420,
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
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "suhair"),
                      ),

                      const SizedBox(height: 10),

                     Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "email@gmail.com"),
                      ),

                      const SizedBox(height: 10),
                      
                     Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                       decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "7541248544"),
                      ),

                      const SizedBox(height: 10),

                     Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "2021"),
                      ),
                      
                      const SizedBox(height: 10),

                     Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "7487"),
                      ),
                      
                      const SizedBox(height: 10),

                     Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal:20),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child : const Text( "9876543210"),
                      ),
                  
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



