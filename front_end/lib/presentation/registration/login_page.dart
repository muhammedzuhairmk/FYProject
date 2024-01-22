// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/main_page/screen_main.dart';
import 'package:front_end/presentation/registration/forget_pass.dart';
import 'package:front_end/presentation/registration/registration_page.dart';

//import 'package:front_end/core/constant/colors.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final _GmailKey = GlobalKey<FormState>();
  final _PassKey = GlobalKey<FormState>();
  final _gmailController = TextEditingController();
  final _passController = TextEditingController();

  bool _securePass = true;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 10,
          toolbarHeight: 100,
          backgroundColor:const Color.fromARGB(255, 246, 246, 246),
          title: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Event Snap",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: backGroundColor,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Welcome back",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 25,
              ),

              //gmail
              Form(
                key: _GmailKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: TextFormField(
                      controller: _gmailController,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        fillColor: Color.fromARGB(212, 237, 235, 235),
                        filled: true,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Gmail",
                      ),
                      validator: (value) {
                        if (!EmailValidator.validate(_gmailController.text)) {
                          return "Please enter a valid gmail";
                        } else {
                          return null;
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              //PASSWORD

              Form(
                key: _PassKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        fillColor: const Color.fromARGB(212, 237, 235, 235),
                        filled: true,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _securePass = !_securePass;
                              });
                            },
                            icon: Icon(_securePass
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      obscureText: _securePass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the password number";
                        } else {
                          return null;
                        }
                      }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forget_Pass()));
                      },
                      child: const Text(
                        "forget password",
                        style: TextStyle(
                            color: Color.fromARGB(255, 3, 87, 157),
                            fontSize: 15),
                      )),
                ]),
              ),
              const SizedBox(
                height: 38,
              ),

              //button

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: 250,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      var form1 = _GmailKey.currentState!.validate();
                      var form2 = _PassKey.currentState!.validate();
                      if (form1 && form2) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 189, 3, 47),
                        shadowColor: Colors.black,
                        elevation: 15),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("No account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Reg_page()));
                    },
                    child: const Text(
                      " Create",
                      style: TextStyle(color: Color.fromARGB(255, 3, 87, 157)),
                    ))
              ]),
            ]),
          ),
        )));
  }
}
