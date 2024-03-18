import 'package:flutter/material.dart';

class camara extends StatelessWidget {
  const camara({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(
              'EventSnap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    ),
    
    );
  }
}