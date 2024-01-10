import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'presentation/main_page/screen_main.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: BackGroundColor,
        
      ),
      home: HomeScreen(),
    );
  }
}

  // This widget is the root of your application.
  