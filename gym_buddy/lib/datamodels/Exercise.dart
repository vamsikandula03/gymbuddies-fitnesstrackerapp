import 'package:gym_buddy/data/data.dart';
import 'package:gym_buddy/datamodels/ExerciseSet.dart';

class Exercise {
  late int id;
  late String name;
  List<Exerciseset>? sets;
  Exercise(name, id) {
    this.name = name;
    this.id = id;
    sets = [];
  }
}
