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
  TextEditingController admissionNumberController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isEditingPersonalDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Full Name: John Doe'), // Replace with actual user data
            Text(
                'Email: john.doe@example.com'), // Replace with actual user data
            Text('Phone Number: 1234567890'), // Replace with actual user data
            Text('Admission Number: A12345'), // Replace with actual user data
            SizedBox(height: 20),
            !_isEditingPersonalDetails
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditingPersonalDetails = true;
                        fullNameController.text =
                            'John Doe'; // Initialize with actual user data
                        emailController.text =
                            'john.doe@example.com'; // Initialize with actual user data
                        phoneNumberController.text =
                            '1234567890'; // Initialize with actual user data
                        admissionNumberController.text =
                            'A12345'; // Initialize with actual user data
                      });
                    },
                    child: Text('Edit Personal Details'),
                  )
                : Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        decoration: InputDecoration(labelText: 'Full Name'),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                      ),
                      TextField(
                        controller: admissionNumberController,
                        decoration:
                            InputDecoration(labelText: 'Admission Number'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Save updated personal details
                            _isEditingPersonalDetails = false;
                          });
                        },
                        child: Text('Save Personal Details'),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            Text(
              'Change Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle password change logic
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccountPage(),
  ));
}
