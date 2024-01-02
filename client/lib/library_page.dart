import 'package:client/workout.dart';
import 'package:client/workout_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  final user = FirebaseAuth.instance.currentUser;
  List<Workout> workouts = [];

  void printText(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  void fetchRecords() async {
    var workouts = await dbRef.get();
    mapRecords(workouts);
  }

  void mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    List<Workout> workoutsBuilder = [];
    for (var i = 0; i < records.docs.length; i++) {
      var doc = records.docs[i];
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

      for (var j = 0; j < doc["usedBy"].length; j++) {
        usedBy.add(UserPreference(
            email: doc["usedBy"][j]["email"],
            isFav: doc["usedBy"][j]["isFav"]));

        if ((doc["usedBy"][j]["email"] == user?.email)) {
          usedByCurrentUser = true;
          usedByIndex = j;
          skip = false;
          continue;
        }
      }
      if (skip) {
        continue;
      }
      for (var j = 0; j < doc["monday"].length; j++) {
        var currentExercise = doc["monday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        monday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["tuesday"].length; j++) {
        var currentExercise = doc["tuesday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        tuesday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["wednesday"].length; j++) {
        var currentExercise = doc["wednesday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        wednesday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["thursday"].length; j++) {
        var currentExercise = doc["thursday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        thursday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["friday"].length; j++) {
        var currentExercise = doc["friday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        friday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["saturday"].length; j++) {
        var currentExercise = doc["saturday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        saturday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      for (var j = 0; j < doc["sunday"].length; j++) {
        var currentExercise = doc["sunday"][j];
        ExerciseDetails details =
            ExerciseDetails(name: currentExercise["name"]);
        sunday.add(Exercise(
            details: details,
            reps: currentExercise["reps"],
            sets: currentExercise["sets"],
            weight: currentExercise["weight"],
            mins: currentExercise["mins"]));
      }
      workoutsBuilder.add(Workout(
          id: doc.id,
          name: doc["name"],
          creator: doc["creator"],
          usedBy: usedBy,
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
          sunday: sunday,
          usedByIndex: usedByIndex,
          usedByCurrentUser: usedByCurrentUser));
    }
    setState(() {
      workouts = workoutsBuilder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return workouts.isNotEmpty
        ? ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(workouts[index].name),
                subtitle: Text(workouts[index].creator),
                leading: IconButton(
                  onPressed: () async {
                    var records = await dbRef.get();
                    List usedBy = [];
                    for (var i = 0; i < records.docs.length; i++) {
                      var doc = records.docs[i];
                      for (var j = 0; j < doc["usedBy"].length; j++) {
                        var currentUserPref = doc["usedBy"][j];
                        if (j == workouts[index].usedByIndex) {
                          usedBy.add({
                            "email": currentUserPref["email"],
                            "isFav":
                                currentUserPref["isFav"] == false ? true : false
                          });
                        } else {
                          usedBy.add({
                            "email": currentUserPref["email"],
                            "isFav": currentUserPref["isFav"]
                          });
                        }
                      }
                    }

                    dbRef.doc(workouts[index].id).update({'usedBy': usedBy});
                    setState(() {
                      fetchRecords();
                    });
                  },
                  icon: Icon(workouts[index]
                          .usedBy[workouts[index].usedByIndex ?? 0]
                          .isFav
                      ? Icons.grade_rounded
                      : Icons.grade_outlined),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Are You Sure?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    var record = await dbRef
                                        .doc(workouts[index].id)
                                        .get();
                                    List<UserPreference> usedBy = [];
                                    List<Map<String, dynamic>> updatedUsedBy =
                                        [];
                                    for (var i = 0;
                                        i < record["usedBy"].length;
                                        i++) {
                                      var currentUserPref = record["usedBy"][i];
                                      if (currentUserPref["email"] !=
                                          user?.email) {
                                        usedBy.add(UserPreference(
                                            email: currentUserPref["email"],
                                            isFav: currentUserPref["isFav"]
                                                as bool));
                                        updatedUsedBy.add({
                                          "email": currentUserPref["email"],
                                          "isFav":
                                              currentUserPref["isFav"] as bool
                                        });
                                      }
                                    }

                                    dbRef
                                        .doc(workouts[index].id)
                                        .update({'usedBy': updatedUsedBy});
                                    Navigator.pop(context, 'Remove');
                                    setState(() {
                                      fetchRecords();
                                    });
                                  },
                                  child: const Text("Remove")),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.delete_outline_outlined),
                  selectedIcon: const Icon(Icons.delete_rounded),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              WorkoutView(id: workouts[index].id)));
                },
              );
            })
        : const Text("Look's like you haven't saved any workouts yet");
  }
}
