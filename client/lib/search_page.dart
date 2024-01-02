import 'package:client/workout.dart';
import 'package:client/workout_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            email: doc["usedBy"][j]["email"],
            isFav: doc["usedBy"][j]["isFav"]));
        if ((doc["usedBy"][j]["email"] == user?.email)) {
          usedByCurrentUser = true;
        }
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
          monday: monday,
          tuesday: tuesday,
          wednesday: wednesday,
          thursday: thursday,
          friday: friday,
          saturday: saturday,
          sunday: sunday,
          usedBy: usedBy,
          usedByCurrentUser: usedByCurrentUser));
    }
    setState(() {
      workouts = workoutsBuilder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workouts[index].name),
            subtitle: Text(workouts[index].creator),
            trailing: IconButton(
              onPressed: () async {
                var records = await dbRef.get();
                List usedBy = [];
                for (var i = 0; i < records.docs.length; i++) {
                  var doc = records.docs[i];
                  for (var j = 0; j < doc["usedBy"].length; j++) {
                    var currentUserPref = doc["usedBy"][j];
                    if (currentUserPref["email"] != user?.email) {
                      usedBy.add({
                        "email": currentUserPref["email"],
                        "isFav": currentUserPref["isFav"] as bool
                      });
                    }
                  }
                }
                usedBy.add({"email": user?.email, "isFav": false});

                dbRef.doc(workouts[index].id).update({'usedBy': usedBy});
                setState(() {
                  fetchRecords();
                });
              },
              icon: Icon(workouts[index].usedByCurrentUser
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline),
              tooltip: "Save Workout",
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WorkoutView(id: workouts[index].id)));
            },
          );
        });
  }
}

class WorkoutListItem extends StatefulWidget {
  const WorkoutListItem({
    super.key,
    required this.name,
    required this.creator,
    this.isFav,
    required this.id,
    this.usedByIndex,
  });

  final String name;
  final String creator;
  final bool? isFav;
  final String id;
  final int? usedByIndex;

  @override
  State<WorkoutListItem> createState() => _WorkoutListItemState();
}

class _WorkoutListItemState extends State<WorkoutListItem> {
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Text(widget.creator),
      trailing: IconButton(
        onPressed: () async {
          var workouts = await dbRef.get();
          List usedBy = [];
          for (var i = 0; i < workouts.docs.length; i++) {
            var doc = workouts.docs[i];
            for (var j = 0; j < doc["usedBy"].length; j++) {
              var currentUserPref = doc["usedBy"][j];
              if (currentUserPref["email"] != user?.email) {
                usedBy.add({
                  "email": currentUserPref["email"],
                  "isFav": currentUserPref["isFav"] as bool
                });
              }
            }
          }
          usedBy.add({"email": user?.email, "isFav": false});

          dbRef.doc(widget.id).update({'usedBy': usedBy});
          setState(() {});
        },
        icon: const Icon(Icons.bookmark_outline_outlined),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkoutView(id: widget.id)));
      },
    );
  }
}
