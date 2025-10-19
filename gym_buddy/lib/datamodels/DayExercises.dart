import 'package:flutter/material.dart';
import 'package:gym_buddy/datamodels/Exercise.dart';

class DayExercises {
  DateTime date;
  late List<Exercise> exercises;

  DayExercises({required this.date}){
    exercises = [];
  }
}
