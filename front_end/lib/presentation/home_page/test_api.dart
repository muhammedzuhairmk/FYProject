import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestApi extends StatefulWidget {
  const TestApi({super.key});

  @override
  State<TestApi> createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {


Future fetchAlbum() async {
  final response = await http
      .get(Uri.parse('http://localhost:3000/name'));

  if (response.statusCode == 200) {
    // ignore: avoid_print
    print(response.body);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
    ));
  }
}