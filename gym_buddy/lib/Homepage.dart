import 'package:flutter/material.dart';
import 'package:gym_buddy/Exercisepage.dart';
import 'package:gym_buddy/data/data.dart';
import 'package:gym_buddy/datamodels/Exercise.dart';

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
            Text('Welcome  $username'),
            Row(
              children: [
                Text('Select the date:'),
                TextButton(
                    onPressed: _pickDate,
                    child:
                        Text(selectedDate.toLocal().toString().split(' ')[0])),
              ],
            ),
            ElevatedButton(
                onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (context) {
                            String? selectedExercise;
                            return AlertDialog(
                              title: Text('Add Exercise'),
                              content: DropdownButton<String>(
                                hint: Text('Select Exercise'),
                                value: selectedExercise,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedExercise = newValue;
                                  });
                                },
                                items: Exercises.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    if (selectedExercise != null) {
                                      setState(() {
                                        filteredExercisesByDate(selectedDate)
                                            .exercises
                                            .add(
                                                Exercise(selectedExercise!, 1));
                                      });
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Add'),
                                ),
                              ],
                            );
                          })
                    },
                child: Text('Add Exercise')),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(

color: Colors.grey[300],

                                  borderRadius: BorderRadius.circular(10),
                                  
                                  ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                      GestureDetector(
                        child: Row(children: [
                          Text(filteredExercisesByDate(selectedDate)
                              .exercises[index]
                              .name!)
                        ]),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Exercisepage(
                                    date: selectedDate, exerciseIndex: index))),
                      ),
                      IconButton(onPressed: () => {
                            setState(() {
                              filteredExercisesByDate(selectedDate)
                                  .exercises
                                  .removeAt(index);
                            })

                      }, icon: Icon(Icons.delete))
                    ]));
                  },
                  itemCount:
                      filteredExercisesByDate(selectedDate).exercises?.length),
            )
          ],
        ),
      ),
    );
  }
}
