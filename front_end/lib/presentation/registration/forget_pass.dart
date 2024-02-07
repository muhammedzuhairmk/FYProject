import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/registration/login_page.dart';

//import 'package:front_end/core/constant/colors.dart';

class forget_Pass extends StatefulWidget {
  forget_Pass({super.key});

  @override
  State<forget_Pass> createState() => _forget_PassState();
}

class _forget_PassState extends State<forget_Pass> {
  final _GmailKey = GlobalKey<FormState>();
  final _PassKey = GlobalKey<FormState>();
  final _conPassKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();

  final _GmailController = TextEditingController();
  final _passController = TextEditingController();
  final _ConpassController = TextEditingController();
  final _otpController = TextEditingController();

  bool _securePass = true;
  bool _consecurePass = true;
  bool _visi = true;
  bool _visi2 = false;
  bool _visi3 = false;
  var bt = "Next";
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => login_page()));
                }),
            shadowColor: Colors.black,
            elevation: 10,
            toolbarHeight: 100,
            backgroundColor: Color.fromARGB(255, 246, 246, 246),
            title: const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Text(
                "Forget password",
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

                const SizedBox(
                  height: 25,
                ),

                //gmail
                Visibility(
                  visible: _visi,
                  child: Form(
                    key: _GmailKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35, left: 35),
                      child: TextFormField(
                          controller: _GmailController,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            fillColor: Color.fromARGB(212, 237, 235, 235),
                            filled: true,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Gmail",
                          ),
                          validator: (value) {
                            if (!EmailValidator.validate(
                                _GmailController.text)) {
                              return "Please enter a valid gmail";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                //otp

                Visibility(
                  visible: _visi2,
                  child: Form(
                    key: _otpKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35, left: 35),
                      child: TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            fillColor: Color.fromARGB(212, 237, 235, 235),
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            hintText: "OTP",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the OTP";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                //PASSWORD

                Visibility(
                  visible: _visi3,
                  child: Form(
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
                              return "Please enter the Password";
                            } else if (value.length < 4) {
                              return "Password must contain atleast 4 digits";
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                //conpass
                Visibility(
                  visible: _visi3,
                  child: Form(
                    key: _conPassKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35, left: 35),
                      child: TextFormField(
                          controller: _ConpassController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            fillColor: const Color.fromARGB(212, 237, 235, 235),
                            filled: true,
                            hintText: "confirm Password",
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _consecurePass = !_consecurePass;
                                  });
                                },
                                icon: Icon(_consecurePass
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          obscureText: _consecurePass,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter the confirm password";
                            } else if (value != _passController.text) {
                              return "Please check the password";
                            } else {
                              return null;
                            }
                          }),
                    ),
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
                        if (i == 0) {
                          var form1 = _GmailKey.currentState!.validate();
                          if (form1) {
                            setState(() {
                              _visi = false;
                              _visi2 = true;
                              i++;
                            });
                          }
                        } else if (i == 1) {
                          var form2 = _otpKey.currentState!.validate();
                          if (form2) {
                            setState(() {
                              _visi2 = false;
                              _visi3 = true;
                              bt = "submit";
                              i++;
                            });
                          }
                        } else if (i == 2) {
                          var form3 = _PassKey.currentState!.validate();
                          var form4 = _conPassKey.currentState!.validate();
                          if (form3 && form4) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => login_page()));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 189, 3, 47),
                          shadowColor: Colors.black,
                          elevation: 15),
                      child: Text(
                        bt,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ))),
    );
  }
}
