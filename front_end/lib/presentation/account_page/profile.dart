// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class AccountProfilePage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController admissionNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  ListView(
          children: [
           
           
            const SizedBox(height: 20),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  "Account Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: admissionYearController,
              decoration: const InputDecoration(
                labelText: 'Admission Year',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: admissionNumberController,
              decoration: const InputDecoration(
                labelText: 'Admission Number',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility_off),
                  onPressed: () {
                    // Handle password visibility toggle
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                  // Navigate to UpdateProfileScreen or perform form submission
                },
                child: const Text('Update Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> stepList() {
    return [
      Step(
        title: const Text('Step 1'),
        content: const Text('Content for Step 1'),
        isActive: _currentStep == 0,
      ),
      Step(
        title: const Text('Step 2'),
        content: const Text('Content for Step 2'),
        isActive: _currentStep == 1,
      ),
      // Add more steps as needed
    ];
  }
}
