import 'package:flutter/material.dart';
import 'package:front_end/presentation/account_page/pickProfile.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController admissionYearController = TextEditingController();
  TextEditingController admissionNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isEditingPersonalDetails = false;

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            pickProfile(),
            SizedBox(height: 20),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
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
                margin: EdgeInsets.all(20),
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
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: admissionYearController,
              decoration: const InputDecoration(
                labelText: 'Admission Year',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: admissionNumberController,
              decoration: const InputDecoration(
                labelText: 'Admission Number',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off),
                  onPressed: () {
                    // Handle password visibility toggle
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                  // Navigate to UpdateProfileScreen or perform form submission
                },
                child: Text('Update Profile'),
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
        title: Text('Step 1'),
        content: Text('Content for Step 1'),
        isActive: _currentStep == 0,
      ),
      Step(
        title: Text('Step 2'),
        content: Text('Content for Step 2'),
        isActive: _currentStep == 1,
      ),
      // Add more steps as needed
    ];
  }
}
