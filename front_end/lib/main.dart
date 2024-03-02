// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:front_end/presentation/splash_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:get/get.dart';


const save_key_name= "jhvdb";

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {

  final token;
  const MyApp({
    @required this.token,
    Key? key,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Snap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: mainColor,
        useMaterial3: true,
      ),
      home: const  SplashScreen()
    );
  }
}





