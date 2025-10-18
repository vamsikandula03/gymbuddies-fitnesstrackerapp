import "package:flutter/material.dart";

class Exercisepage extends StatelessWidget {
  const Exercisepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Details'),
      ),
      body: Center(
        child: Text('Details of the selected exercise will be shown here.'),
      ),
    );
  }
}