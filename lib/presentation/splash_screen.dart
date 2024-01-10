import 'dart:async';
import 'package:flutter/material.dart';



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
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData( primaryColor: const Color.fromARGB(255, 119, 192, 251),);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 103, 224, 238),
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
                style: theme.textTheme.headline2,
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
                  onTapSignIn(context);
                },
                child: Text("Sign In"),
              ),
              const SizedBox(height: 17),
              OutlinedButton(
                onPressed: () {
                  onTapSignUp(context);
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
  Navigator.pushNamed(context, AppRoutes.signInScreen);
}

void onTapSignUp(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.signUpScreen);
}

class AppRoutes {
  static const String signInScreen = '/signin';
  static const String signUpScreen = '/signup';
}







