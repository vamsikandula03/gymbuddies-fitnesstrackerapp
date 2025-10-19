import 'package:flutter/material.dart';
import 'package:gym_buddy/Homepage.dart';
import 'package:gym_buddy/data/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     initializeuserdata();
    return MaterialApp(
      home: Homepage(),
    );
  }
}
