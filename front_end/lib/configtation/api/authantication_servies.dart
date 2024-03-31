// ignore_for_file: avoid_print, use_build_context_synchronously, use_rethrow_when_possible

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:front_end/presentation/event_list_page/widget/screen_event_list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/routes.dart';
import '../../presentation/registration/login_page.dart';

Future<void> signUp(String name, String email, String password,
    String confirmPwd, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(registration),
      headers: {
        'Accept': "*/*",
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
     ;
    } else {
      print('Error signing up: ${response.statusCode}');
       
          CustomDialog.showDialogBox(
            context,
            'Failed to signing up',
            'signup updating failed. Status: ${response.statusCode}',
          );
      // Handle signup errors here
      // You might want to throw an exception or return an error message
    }
  } catch (e) {
    print('Error signing up: $e');
      CustomDialog.showDialogBox(
        context,
        'Network Error!',
        'Check your connection!',
      );
    // Handle signup errors here
    throw e; // Rethrow the exception for the caller to handle
  }
}
 
    


class AuthenticationService {
  // Key for storing the auth token in SharedPreferences
  static const String authTokenKey = 'authToken';

  // Save the auth token to SharedPreferences

  static Future<Map<String, String?>> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'authToken': prefs.getString('authToken'),
      'email': prefs.getString('email'),
      'name': prefs.getString('name'),
      'userType': prefs.getString('userType'),
    };
  }
  
  Future<void> saveUserDetails(
    String authToken, String email, String name, String userType) async {
  // Use SharedPreferences to save user details locally
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('authToken', authToken);
  prefs.setString('email', email);
  prefs.setString('name', name);
  prefs.setString('userType', userType);
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

  Future<void> signIn(String email, String password, BuildContext context) async {
  try {
    final response = await http.post(
      Uri.parse(login),
      headers: {
        'Accept': "application/json",
      },
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      // Parse the response JSON
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the auth token from the response
      final String authToken = responseData['token'];
      final String email = responseData['data']['email'];
      final String name = responseData['data']['name'];
      final String userType = responseData['data']['role'];

      // Save the auth token
      await saveUserDetails(authToken, email, name, userType);

      print('Signed in successfully!');
    } else {
      print('Error signing in: ${response.statusCode}');
        CustomDialog.showDialogBox(
            context,
            'Failed to signing in',
            'signin updating failed. Status: ${response.statusCode}',
          );
      // Handle sign-in errors here
    }
  } catch (e) {
    print('Error signing in: $e');
    CustomDialog.showDialogBox(
        context,
        'Network Error!',
        'Check your connection!',
      );
    // Handle sign-in errors here
    throw e; // Rethrow the exception for the caller to handle
  }
}

}

class UserSuccessfully {
  static void showDialogBox(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => login_page()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}