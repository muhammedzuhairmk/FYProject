// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../main_page/screen_main.dart';

import 'registration_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  final getConnect = GetConnect();
  final get_storage = GetStorage();

  void _login(email,pass) async{

    if(email.isEmpty || pass.isEmpty){
      Get.snackbar("Please Enter Email And Password", '');
    }else{
      final res = await getConnect.post('http://192.168.14.131:3000/userLogin', {
        "email":email,
        "password":pass

      });

      if(res.body['status']){
        get_storage.write('user', res.body['success']);
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>const HomeScreen()));
      }else{
        Get.snackbar(res.body['success'], '');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                const Text("* URL SHORTENER *",style: TextStyle(fontSize: 30),),
                const Text("Login Page"),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 2),
                  child: TextField(
                    controller: emailText,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 2),
                  child: TextField(
                    controller: passText,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                      _login(emailText.text,passText.text);
          
                  },
                  child: const Text("LOGIN"),
                ),

                Padding(padding: const EdgeInsets.all(20),child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>const Registration()));
                  },
                  child: const Text("REGISTER"),
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}