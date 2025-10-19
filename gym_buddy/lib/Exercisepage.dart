import "package:flutter/material.dart";
import "package:gym_buddy/data/data.dart";
import "package:gym_buddy/datamodels/Exercise.dart";
import "package:gym_buddy/datamodels/ExerciseSet.dart";

class Exercisepage extends StatefulWidget {
  DateTime date;
  int exerciseIndex;
  Exercisepage({super.key, required this.date, required this.exerciseIndex});
  @override
  State<Exercisepage> createState() => _ExercisepageState();
}

class _ExercisepageState extends State<Exercisepage> {
  @override
  Widget build(BuildContext context) {
    Exercise exercise =
        filteredExercisesByDate(widget.date).exercises[widget.exerciseIndex];
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(exercise.name),
              Text(widget.date.toLocal().year.toString() +
                  "/" +
                  widget.date.toLocal().month.toString() +
                  "/" +
                  widget.date.toLocal().day.toString())
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Text('Exercise Details for ${exercise.name}'),
              ElevatedButton(
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (context) {
                              String reps = "";
                              String weight = "";
                              return AlertDialog(
                                title: Text('Add Set'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration:
                                          InputDecoration(labelText: 'Reps'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        reps = value;
                                      },
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: 'Weight (kg)'),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        weight = value;
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        exercise.sets?.add(Exerciseset(
                                            int.parse(reps),
                                            double.parse(weight),
                                            (exercise.sets?.length ?? 0) + 1));
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Add'),
                                  ),
                                ],
                              );
                            })
                      },
                  child: Text('Add Set')),
              Expanded(
                  child: ListView.builder(
                itemCount: exercise.sets?.length ?? 0,
                itemBuilder: (context, index) {
                  final set = exercise.sets![index];
                  return Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              child: Text(
                                  'Set ${index + 1}: ${set.reps} reps at ${set.weight} kg'),
                            ),
                            onTap: () => {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  String reps = set.reps.toString();
                                  String weight = set.weight.toString();
                                  return AlertDialog(
                                    title: Text('Edit Set'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              labelText: 'Reps'),
                                          keyboardType: TextInputType.number,
                                          controller:
                                              TextEditingController(text: reps),
                                          onChanged: (value) {
                                            reps = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              labelText: 'Weight (kg)'),
                                          keyboardType: TextInputType.number,
                                          controller: TextEditingController(
                                              text: weight),
                                          onChanged: (value) {
                                            weight = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            set.reps = int.parse(reps);
                                            set.weight = double.parse(weight);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              )
                            },
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  exercise.sets?.removeAt(index);
                                });
                              },
                              child: Icon(Icons.delete))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ));
                },
              ))
            ],
          ),
        ));
  }
}
