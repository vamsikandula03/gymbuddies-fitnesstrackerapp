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

 void _showAddExerciseDialog() {
  String? selectedExercise;
  TextEditingController newExerciseController = TextEditingController();
  bool addingCustom = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setStateDialog) {
        return AlertDialog(
          title: const Text("Add Exercise"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!addingCustom)
                DropdownButtonFormField<String>(
                  value: selectedExercise,
                  hint: const Text("Select Exercise"),
                  items: Exercises.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                  onChanged: (val) => setStateDialog(() => selectedExercise = val),
                ),
              if (addingCustom)
                TextField(
                  controller: newExerciseController,
                  decoration: const InputDecoration(
                    labelText: "New exercise name",
                    border: OutlineInputBorder(),
                  ),
                ),
              TextButton(
                onPressed: () => setStateDialog(() => addingCustom = !addingCustom),
                child: Text(addingCustom ? "Select from list" : "Add new exercise"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String? exerciseName =
                    addingCustom ? newExerciseController.text.trim() : selectedExercise;

                if (exerciseName != null && exerciseName.isNotEmpty) {
                  setState(() {
                    // Add new exercise globally if not already present
                    if (!Exercises.contains(exerciseName)) {
                      Exercises.add(exerciseName);
                    }

                    // Add to the selected day's exercises
                    filteredExercisesByDate(selectedDate).exercises
                        .add(Exercise(exerciseName, filteredExercisesByDate(selectedDate).exercises.length + 1));
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      });
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final exercises = filteredExercisesByDate(selectedDate).exercises;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Gym Buddy",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: _showAddExerciseDialog,
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1f1c2c), Color(0xFF928DAB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome $username 👋",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white70),
                        Text(
                          selectedDate.toLocal().toString().split(' ')[0],
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white70),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Today's Exercises",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: exercises.isEmpty
                      ? const Center(
                          child: Text(
                            "No exercises added yet!",
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = exercises[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Exercisepage(
                                    date: selectedDate,
                                    exerciseIndex: index,
                                  ),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.fitness_center,
                                            color: Colors.white, size: 24),
                                        const SizedBox(width: 10),
                                        Text(
                                          exercise.name!,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                                      onPressed: () {
                                        setState(() {
                                          exercises.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
