import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/routes.dart';
import '../../presentation/main_page/screen_main.dart';
import '../../presentation/registration/login_page.dart';

Future<void> signUp(String name, String email, String password,
    String confirmPwd, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(registration),
      headers: {
        'Accept': "application/json",
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPwd,
      },
    );

    if (response.statusCode == 201) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      print('Signed up successfully!');

      // Extract any additional information you may need from the response
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => login_page()));
    } else {
      print('Error signing up: ${response.statusCode}');
      // Handle signup errors here
      // You might want to throw an exception or return an error message
    }
  } catch (e) {
    print('Error signing up: $e');
    // Handle signup errors here
    throw e; // Rethrow the exception for the caller to handle
  }
}

Future<void> signIn(String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(login),
      body: {'username': email, 'password': password},
    );

    if (response.statusCode == 201) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the auth token from the response
      final String authToken = responseData['token'];
      final String username = responseData['data']['email'];
      final String name = responseData['data']['name'];
      final String userType = responseData['data']['role'];

      // Save the auth token
      await saveUserDetails(authToken, username, name, userType);

      print('Signed in successfully!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      print('Error signing in: ${response.statusCode}');
      // Handle sign-in errors here
    }
  } catch (e) {
    print('Error signing in: $e');
    // Handle sign-in errors here
    throw e; // Rethrow the exception for the caller to handle
  }
}

Future<void> saveUserDetails(
    String authToken, String username, String name, String userType) async {
  // Use SharedPreferences to save user details locally
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('authToken', authToken);
  prefs.setString('username', username);
  prefs.setString('name', name);
  prefs.setString('userType', userType);
}

class AuthenticationService {
  // Key for storing the auth token in SharedPreferences
  static const String authTokenKey = 'authToken';

  // Save the auth token to SharedPreferences

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'username': prefs.getString('username'),
      'name': prefs.getString('name'),
      'userType': prefs.getString('userType'),
    };
  }

  // Retrieve the auth token from SharedPreferences
  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  // Method to check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final String? authToken = await getAuthToken();
    return authToken != null;
  }

  Future<void> signOut() async {
    try {
      // Retrieve the auth token from SharedPreferences
      final String? authToken = await getAuthToken();

      // Clear the auth token from SharedPreferences
      // Passing empty strings for user details

      final response = await http.post(
        Uri.parse('/api/mobile/logout/'),
        headers: {
          'Authorization':
              'Token $authToken', // Include the auth token in the headers
        },
        // Additional headers or data if needed
      );

      if (response.statusCode == 200) {
        await saveUserDetails('', '', '', '');
        print('Signed out successfully!');
      } else {
        print('Error signing out: ${response.statusCode}');
        // Handle sign-out errors here
      }
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out errors here
      throw e; // Rethrow the exception for the caller to handle
    }
  }
}
