import 'package:flutter/material.dart';
import 'package:gym_buddy/data/data.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
         selectedDate = picked;
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gym Buddy'),
        ),
        body: Column(
          children: [
            Text('Welcome to Gym Buddy!'),
            Row(
              children: [
                Text('Select the date:'),
                TextButton(onPressed: _pickDate, child: Text(selectedDate.toLocal().toString().split(' ')[0])),
                // Date picker widget can be added here
              ],
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredExercisesByDate(selectedDate)[index].name),
                );
              }, itemCount: filteredExercisesByDate(selectedDate).length),
            )
          ],
        ),
      ),
    );
  }
}
