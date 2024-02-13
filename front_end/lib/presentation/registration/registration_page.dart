// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:front_end/configtation/api/authantication_servies.dart';
import 'package:front_end/core/constant/colors.dart';

import 'package:email_validator/email_validator.dart';
import 'package:front_end/presentation/registration/login_page.dart';

class Reg_page extends StatefulWidget {
  Reg_page({super.key});

  @override
  State<Reg_page> createState() => _Reg_pageState();
}

class _Reg_pageState extends State<Reg_page> {
//key

  final _NameKey = GlobalKey<FormState>();
  final _GmailKey = GlobalKey<FormState>();
  final _PassKey = GlobalKey<FormState>();
  final _ConPassKey = GlobalKey<FormState>();

//textediting  controllers

  final NameController = TextEditingController();
  final GmailController = TextEditingController();
  final passController = TextEditingController();
  final ConPassController = TextEditingController();

  bool _securePass = true;
  bool _secureConPass = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.black, onPressed: () { Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_page()));}),
            shadowColor: Colors.black,
            elevation: 10,
            toolbarHeight: 100,
            backgroundColor: const Color.fromARGB(255, 246, 246, 246),
            title: const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Create an account",
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
                  height: 50,
                ),
                //username

                Form(
                  key: _NameKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35, left: 35),
                    child: TextFormField(
                        controller: NameController,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: Color.fromARGB(212, 237, 235, 235),
                          filled: true,
                          hintText: "Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the name";
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                //gmail
                Form(
                  key: _GmailKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35, left: 35),
                    child: TextFormField(
                        controller: GmailController,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor:  Color.fromARGB(212, 237, 235, 235),
                          filled: true,
                          prefixIcon:  Icon(Icons.mail),
                          hintText: "Gmail",
                        ),
                        validator: (value) {
                          if (!EmailValidator.validate(GmailController.text)) {
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
                            return "Please enter the Password";
                          } else if (value.length < 4) {
                            return "Password must contain atleast 4 digits";
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),

                //Confirm password
                const SizedBox(
                  height: 8,
                ),

                Form(
                  key: _ConPassKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35, left: 35),
                    child: TextFormField(
                        controller: ConPassController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          fillColor: const Color.fromARGB(212, 237, 235, 235),
                          filled: true,
                          hintText: "Confirm password",
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureConPass = !_secureConPass;
                              });
                            },
                            icon: Icon(_secureConPass
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter the confirm password";
                          } else if (value != passController.text) {
                            return "Please check the password";
                          } else {
                            return null;
                          }
                        }),
                  ),
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
                        var form1 = _NameKey.currentState!.validate();
                        var form2 = _GmailKey.currentState!.validate();
                        var form4 = _PassKey.currentState!.validate();
                        var form5 = _ConPassKey.currentState!.validate();
                        if (form1 && form2 && form5 && form4) {
                          signUp(
                              NameController.text,
                              GmailController.text,
                              passController.text,
                              ConPassController.text,
                              context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 189, 3, 47),
                          shadowColor: Colors.black,
                          elevation: 15),
                      child: const Text(
                        "Create account",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_page()));
                      },
                      child: const Text(
                        " Signin",
                        style:
                            TextStyle(color: Color.fromARGB(255, 3, 87, 157)),
                      ))
                ]),
              ]),
            ),
          ))),
    );
  }
}
