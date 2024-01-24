import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  final getConnect = GetConnect();


  void _register(name,email,pass) async{
    print("${name},${email},${pass}");

    if(name.isEmpty || email.isEmpty || pass.isEmpty){
      Get.snackbar("Please Enter Details", '');
    }else{
      final res = await getConnect.post('http://192.168.14.131:3000/userRegistration', {
        "name":name,
        "email":email,
        "password":pass
      });

      if(res.body['status']){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Login()));
      }else{
        Get.snackbar(res.body['success'], 'message');
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
                SizedBox(height: 10,),
                const Text("* URL SHORTENER *",style: TextStyle(fontSize: 30),),
                const Text("Registration Page"),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 2),
                  child: TextField(
                    controller: nameText,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 2),
                  child: TextField(
                    controller: emailText,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20),child:
                ElevatedButton(
                  onPressed: () {
                      _register(nameText.text,emailText.text,passText.text);
                  },
                  child: Text("REGISTER"),
                ),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>Login()));
                  },
                  child: Text("LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}