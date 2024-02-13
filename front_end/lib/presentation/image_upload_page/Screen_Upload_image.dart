

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> updateUserProfile(String newName, String newEmail, File newImage, String token) async {
//   final String url = 'http://your-backend-url/update-profile';
//   final Map<String, String> headers = {
//     'Authorization': 'Bearer $token',
//   };
//   final Map<String, dynamic> changes = {
//     'name': newName,
//     'email': newEmail,
//   };

//   try {
//     final http.MultipartRequest request = http.MultipartRequest('PATCH', Uri.parse(url));
//     request.headers.addAll(headers);

//     // Add text fields
//     for (String key in changes.keys) {
//       request.fields[key] = changes[key];
//     }

//     // Add image file if provided
//     if (newImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('image', newImage.path));
//     }

//     final http.Response response = await http.Response.fromStream(await request.send());

//     if (response.statusCode == 200) {
//       // Profile updated successfully
//     } else {
//       // Error updating profile
//     }
//   } catch (error) {
//     print('Error: $error');
//     // Handle error
//   }
// }
// // Future<void> _uploadImages() async {
// //     if (_formKey.currentState?.validate() == false) {
// //       // Form is not valid, do not proceed with uploading images
// //       return;
// //     }
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     final token = prefs.getString('token');

// //     if (_imageList != null && _imageList!.isNotEmpty) {
// //       var request = http.MultipartRequest(
// //         'POST',
// //         Uri.parse('$baseUrl/add-galleryItem'),
// //       );
// //       print(token);
// //       request.headers['Accept'] = 'application/json';
// //       request.headers['Authorization'] = 'Bearer ${token.toString()}';
// //       // Attach images to the request
// //       for (XFile imageFile in _imageList!) {
// //         request.files.add(await http.MultipartFile.fromPath(
// //           'images[]',
// //           imageFile.path,
// //         ));
// //       }

// //       // Attach additional data
// //       request.fields['title'] = title.text;
// //       request.fields['description'] = description.text;
// //       request.fields['short_description'] = short_description.text;
// //       request.fields['date'] = _dateController.text;

// //       var response = await request.send();

// //       if (response.statusCode == 200) {
// //         // final Map<String, dynamic> responseData = json.decode(response);
// //         Navigator.pop(context, "reload");
// //         CustomDialog.showDialogBox(
// //           context,
// //           'Added successfully',
// //           'Gallery Item added successfully..',
// //         );
// //       } else {
// //         print('Failed to Add. Status Code: ${response.statusCode}');
// //         print('Response Body: ${await response.stream.bytesToString()}');
// //         CustomDialog.showDialogBox(
// //           context,
// //           'Failed to Add',
// //           'Gallery Item adding Failed Status : ${response.statusCode} !!',
// //         );
// //       }
// //     } else {
// //       CustomDialog.showDialogBox(
// //         context,
// //         'No Image Selected',
// //         'Please select at least one Image!!',
// //       );
// //     }
// //   }