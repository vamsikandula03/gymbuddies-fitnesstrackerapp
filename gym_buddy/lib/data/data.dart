import 'package:gym_buddy/datamodels/DayExercises.dart';
import 'package:gym_buddy/datamodels/Exercise.dart';
import 'package:gym_buddy/datamodels/ExerciseSet.dart';

String username = "Vamsi";
List<DayExercises> Userexercises = [
  DayExercises(date: DateTime(2025, 10, 20)),
  DayExercises(date: DateTime(2025, 10, 21)),
];

initializeuserdata()=>{
Userexercises[0].exercises.add(Exercise("Forearms", Userexercises[0].exercises.length + 1)),
Userexercises[1].exercises.add(Exercise("biseps", Userexercises[0].exercises.length + 1)),
Userexercises[1].exercises[0].sets?.addAll([
  Exerciseset(12, 20,1),
  Exerciseset(10, 25,2),
]),
};

DayExercises filteredExercisesByDate(DateTime date) {
  return Userexercises.firstWhere((dayExercise) =>
      dayExercise.date.year == date.year &&
      dayExercise.date.month == date.month &&
      dayExercise.date.day == date.day, orElse: () {
    DayExercises newDayExercise = DayExercises(date: date);
    Userexercises.add(newDayExercise);
    return newDayExercise;
  });
}

List<String> Exercises = ["Forearms", "biseps", "legs"];
