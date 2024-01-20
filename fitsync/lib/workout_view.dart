import 'package:client/edit_workout.dart';
import 'package:client/new_workout.dart';
import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise_list.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key, required this.id});

  final String id;

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  Workout? workout;
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  late final Stream<DocumentSnapshot> _workoutsStream;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _workoutsStream = dbRef.doc(widget.id).snapshots();
    fetchRecord();
  }

  fetchRecord() async {
    var record = await dbRef.doc(widget.id).get();
    mapRecord(record);
  }

  mapRecord(DocumentSnapshot<Map<String, dynamic>> record) {
    var doc = record;
    List<UserPreference> usedBy = [];
    int? usedByIndex;
    List<Exercise> monday = [];
    List<Exercise> tuesday = [];
    List<Exercise> wednesday = [];
    List<Exercise> thursday = [];
    List<Exercise> friday = [];
    List<Exercise> saturday = [];
    List<Exercise> sunday = [];
    bool usedByCurrentUser = false;

    for (var j = 0; j < doc["usedBy"].length; j++) {
      usedBy.add(UserPreference(
          email: doc["usedBy"][j]["email"], isFav: doc["usedBy"][j]["isFav"]));
      if ((doc["usedBy"][j]["email"] == user?.email)) {
        usedByCurrentUser = true;
        usedByIndex = j;
      }
    }
    for (var j = 0; j < doc["monday"].length; j++) {
      var currentExercise = doc["monday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      monday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["tuesday"].length; j++) {
      var currentExercise = doc["tuesday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      tuesday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["wednesday"].length; j++) {
      var currentExercise = doc["wednesday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      wednesday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["thursday"].length; j++) {
      var currentExercise = doc["thursday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      thursday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["friday"].length; j++) {
      var currentExercise = doc["friday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      friday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["saturday"].length; j++) {
      var currentExercise = doc["saturday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      saturday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    for (var j = 0; j < doc["sunday"].length; j++) {
      var currentExercise = doc["sunday"][j];
      ExerciseDetails details = ExerciseDetails(
          name: currentExercise["details"]["name"],
          img: currentExercise["details"]["img"] ??
              "https://picsum.photos/250?image=1",
          equipment: currentExercise["details"]["equipment"],
          type: currentExercise["details"]["type"],
          instructions: currentExercise["details"]["instructions"],
          muscle: currentExercise["details"]["muscle"]);
      sunday.add(Exercise(
          details: details,
          reps: currentExercise["reps"],
          sets: currentExercise["sets"],
          weight: currentExercise["weight"],
          mins: currentExercise["mins"]));
    }
    workout = Workout(
        id: doc.id,
        name: doc['name'],
        creator: doc['creator'],
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
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return StreamBuilder(
        stream: _workoutsStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          mapRecord(snapshot.data as DocumentSnapshot<Map<String, dynamic>>);
          return DefaultTabController(
              length: 7,
              child: Builder(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      workout!.name,
                    ),
                    flexibleSpace: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.09,
                            left: MediaQuery.of(context).size.width * 0.182),
                        child: Text(
                          workout!.creator,
                          style: TextStyle(
                              fontSize: 12.5,
                              color: theme.colorScheme.onPrimary),
                        )),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    bottom: TabBar(
                        indicatorColor: theme.colorScheme.inversePrimary,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              "Su",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Mo",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Tu",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "We",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Th",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Fr",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Sa",
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                            ),
                          ),
                        ]),
                  ),
                  body: TabBarView(children: <Widget>[
                    ExerciseList(
                      exercises: workout!.sunday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.monday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.tuesday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.wednesday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.thursday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.friday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                    ExerciseList(
                      exercises: workout!.saturday,
                      updating: false,
                      onAdd: () {},
                      onDelete: (index) {},
                      updateDetails: (weight, reps, sets, index) {},
                    ),
                  ]),
                  floatingActionButton: workout!.usedByCurrentUser
                      ? FloatingActionButton(
                          onPressed: () {
                            int index = DefaultTabController.of(context).index;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewWorkoutView(
                                workout: workout,
                              );
                            }));
                          },
                          heroTag: "openEditBtn",
                          child: const Icon(Icons.edit),
                        )
                      : null,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                );
              }));
        });
  }
}
