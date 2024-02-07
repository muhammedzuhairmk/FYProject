// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/core/constant/colors.dart';
import 'package:front_end/main.dart';
import 'package:front_end/presentation/main_page/screen_main.dart';
import 'package:front_end/presentation/registration/login_page.dart';
import 'package:front_end/presentation/registration/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () {
        checkUserLoggedIn();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData(
      primaryColor: const Color.fromARGB(255, 6, 34, 56),
    );

    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 88),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 55),
            Text(
              "EventSnap",
              style: TextStyle(fontSize: 60, color: Colors.black),
            ),
            Spacer(flex: 44),
          ],
        ),
      ),
    );
  }

  void checkUserLoggedIn() async {
    final _sharedprefes = await SharedPreferences.getInstance();
    final _userLoggedIn = await _sharedprefes.getBool(save_key_name);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
// ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 27),
              Text(
                "Welcome!",
                style: theme.textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              const Text("Sign in or create a new account",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(10, 1, 1, 1))),
              const SizedBox(height: 16),
              Image.asset('assets/images/image.jpg', height: 223, width: 358),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => login_page()),
                  );
                },
                child: const Text("Sign In"),
              ),
              const SizedBox(height: 17),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Reg_page()),
                  );
                },
                child: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onTapSignIn(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.login_page);
}

void onTapSignUp(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.signUpScreen);
}

class AppRoutes {
  // ignore: constant_identifier_names
  static const String login_page = '/signin';
  static const String signUpScreen = '/signup';
}
