import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/presentation/splash_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'presentation/home_page/widgets/Notification.dart';
import 'presentation/registration/login_page.dart';
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
      home: const HomeScreen(),
    );
  }
}
// This widget is the root of your application.

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final get_storage = GetStorage();
  @override
  void initState() {
    super.initState();

    get_storage.writeIfNull('user', false);

    Future.delayed(const Duration(seconds: 2), () async {
      print(get_storage.read('user'));
      checkUserData();
    });
  }

  checkUserData() {
    if (get_storage.read('user').toString().isNotEmpty ||
        get_storage.read('user')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => const ScreenNotification()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
