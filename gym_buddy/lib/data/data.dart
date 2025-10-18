import 'package:gym_buddy/datamodels/Exercise.dart';

List<Exercise> exercises = [Exercise("forearms",DateTime.parse("2025-10-19")), Exercise("biceps",DateTime.parse("2025-10-20")),Exercise("legs", DateTime.parse("2025-10-20"))];
List<Exercise> filteredExercisesByDate(DateTime date) {
  return exercises.where((exercise) => exercise.date == date).toList();
}