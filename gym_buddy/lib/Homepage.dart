import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gym Buddy'),
        ),
        body: Center(
          child: Text('Welcome to Gym Buddy!'),
        ),
      ),
    );
  }
}