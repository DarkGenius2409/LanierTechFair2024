import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key, required this.id});

  final String id;

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  late Workout workout;
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchRecord();
  }

  fetchRecord() async {
    var record = await dbRef.doc(widget.id).get();
    mapRecord(record);
  }

  mapRecord(DocumentSnapshot<Map<String, dynamic>> records) {
    var doc = records.data();
    List<UserPreference> usedBy = [];
    int? usedByIndex;
    List<Exercise> monday = [];
    List<Exercise> tuesday = [];
    List<Exercise> wednesday = [];
    List<Exercise> thursday = [];
    List<Exercise> friday = [];
    List<Exercise> saturday = [];
    List<Exercise> sunday = [];
    bool skip = true;
    bool usedByCurrentUser = false;

    for (var j = 0; j < doc?["usedBy"].length; j++) {
      usedBy.add(UserPreference(
          email: doc?["usedBy"][j]["email"],
          isFav: doc?["usedBy"][j]["isFav"]));
      if ((doc?["usedBy"][j]["email"] == user?.email)) {
        usedByCurrentUser = true;
        usedByIndex = j;
      }
    }
    for (var j = 0; j < doc?["monday"].length; j++) {
      var currentExercise = doc?["monday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      monday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["tuesday"].length; j++) {
      var currentExercise = doc?["tuesday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      tuesday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["wednesday"].length; j++) {
      var currentExercise = doc?["wednesday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      wednesday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["thursday"].length; j++) {
      var currentExercise = doc?["thursday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      thursday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["friday"].length; j++) {
      var currentExercise = doc?["friday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      friday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["saturday"].length; j++) {
      var currentExercise = doc?["saturday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      saturday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc?["sunday"].length; j++) {
      var currentExercise = doc?["sunday"][j];
      ExerciseDetails details = ExerciseDetails(name: currentExercise["name"]);
      sunday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    setState(() {
      workout = Workout(
          id: records.id,
          name: doc?['name'],
          creator: doc?['creator'],
          usedBy: usedBy,
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
          sunday: sunday,
          usedByCurrentUser: usedByCurrentUser,
          usedByIndex: usedByIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Text(widget.id),
    );
  }
}
