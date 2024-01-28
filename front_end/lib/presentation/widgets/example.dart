import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Uploader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
        pickedFile.path,
        pickedFile.path,
        quality: 50,
      );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/upload'),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          compressedFile!.path,
        ),
      );

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print('Image uploaded successfully');
        } else {
          print('Failed to upload image');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Uploader'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadImage,
          child: Text('Upload Image'),
        ),
      ),
    );
  }
}
