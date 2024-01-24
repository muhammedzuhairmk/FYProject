import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:get_storage/get_storage.dart';
import 'presentation/splash_screen.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Snap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: backGroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
// This widget is the root of your application.


