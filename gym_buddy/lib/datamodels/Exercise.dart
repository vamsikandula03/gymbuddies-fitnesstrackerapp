import 'package:gym_buddy/datamodels/ExerciseSet.dart';

class Exercise {
  DateTime? date;
  String name;
  List<Exerciseset>? sets;
  Exercise(this.name,this.date);
}
