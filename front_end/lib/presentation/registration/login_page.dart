// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/core/constant/routes.dart';
import 'package:front_end/main.dart';
import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:front_end/presentation/main_page/screen_main.dart';
// import 'package:front_end/presentation/registration/forget_pass.dart';
// import 'package:front_end/presentation/registration/registration_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:front_end/core/constant/colors.dart';

class login_page extends StatefulWidget {
  login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final GmailKey = GlobalKey<FormState>();
  final PassKey = GlobalKey<FormState>();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool _securePass = true;

  bool isLoading = false;

  Future<void> loginUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final res = await http.post(Uri.parse(login), body: {
      'email': gmailController.text,
      'password': passController.text,
    });
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      final sharepref = await SharedPreferences.getInstance();
      sharepref.setBool(save_key_name, true);
      print(res.body);
      final Map<String, dynamic> responseData = json.decode(res.body);
      print(responseData['token']);
      final token = responseData['token'].toString();
      prefs.setString('token', token);
      final userid = responseData['_id'].toString();
      prefs.setString('userid', userid);
    } else {
       CustomDialog.showDialogBox(
            context,
            'failed login',
            'Invalid login please try again.',
          );
      //throw Exception("Failed to login");
    }
  }

  void _navigateToReplacement(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          elevation: 10,
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(255, 246, 246, 246),
          title: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Event Snap",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: mainColor,
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
                key: GmailKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: TextFormField(
                      controller: gmailController,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        fillColor: Color.fromARGB(212, 237, 235, 235),
                        filled: true,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Gmail",
                      ),
                      validator: (value) {
                        if (!EmailValidator.validate(gmailController.text)) {
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
                key: PassKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: TextFormField(
                      controller: passController,
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => forget_Pass()));
                  //     },
                  //     child: const Text(
                  //       "forget password",
                  //       style: TextStyle(
                  //           color: Color.fromARGB(255, 3, 87, 157),
                  //           fontSize: 15),
                  //     )),
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
                      var form1 = GmailKey.currentState!.validate();
                      var form2 = PassKey.currentState!.validate();

                      ///to remove
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                      if (form1 && form2) {
                        // _login(context);
                        loginUser(context);
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                // const Text("No account?"),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (context) => Reg_page()));
                //     },
                //     child: const Text(
                //       " Create",
                //       style: TextStyle(color: Color.fromARGB(255, 3, 87, 157)),
                //     ))
              ]),
            ]),
          ),
        )));
  }
}
