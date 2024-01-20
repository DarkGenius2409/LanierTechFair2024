import 'package:client/exercise_selection_screen.dart';
import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise_list.dart';

class EditWorkoutView extends StatefulWidget {
  const EditWorkoutView(
      {super.key, this.id, required this.update, required this.startingTab});

  final String? id;
  final bool update;
  final int startingTab;

  @override
  State<EditWorkoutView> createState() => _EditWorkoutViewState();
}

class _EditWorkoutViewState extends State<EditWorkoutView> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> workoutFuture;
  Workout workout = Workout(
      id: "",
      name: "",
      creator: "",
      usedBy: [],
      monday: [],
      tuesday: [],
      wednesday: [],
      thursday: [],
      friday: [],
      saturday: [],
      sunday: [],
      usedByCurrentUser: false);
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  final user = FirebaseAuth.instance.currentUser;
  final nameTextController = TextEditingController();
  final creatorTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    workoutFuture = fetchRecord();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchRecord() async {
    var record = await dbRef.doc(widget.id!).get();
    return record;
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

    nameTextController.text = workout.name;
  }

  onAdd(BuildContext context, String day) async {
    switch (day) {
      case "monday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.monday.add(exercise);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(workout.monday.toString())));
          });
        }
        break;
      case "tuesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.tuesday.add(exercise);
          });
        }
        break;
      case "wednesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.wednesday.add(exercise);
          });
        }
        break;
      case "thursday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.thursday.add(exercise);
          });
        }
        break;
      case "friday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.friday.add(exercise);
          });
        }
        break;
      case "saturday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.saturday.add(exercise);
          });
        }
        break;
      case "sunday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.sunday.add(exercise);
          });
        }
        break;
      default:
    }
  }

  onDelete(String day) async {
    switch (day) {
      case "monday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.monday.add(exercise);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(workout.monday.toString())));
          });
        }
        break;
      case "tuesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.tuesday.add(exercise);
          });
        }
        break;
      case "wednesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.wednesday.add(exercise);
          });
        }
        break;
      case "thursday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.thursday.add(exercise);
          });
        }
        break;
      case "friday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.friday.add(exercise);
          });
        }
        break;
      case "saturday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.saturday.add(exercise);
          });
        }
        break;
      case "sunday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.sunday.add(exercise);
          });
        }
        break;
      default:
    }
  }

  updateDetails(String day) async {
    switch (day) {
      case "monday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.monday.add(exercise);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(workout.monday.toString())));
          });
        }
        break;
      case "tuesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.tuesday.add(exercise);
          });
        }
        break;
      case "wednesday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.wednesday.add(exercise);
          });
        }
        break;
      case "thursday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.thursday.add(exercise);
          });
        }
        break;
      case "friday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.friday.add(exercise);
          });
        }
        break;
      case "saturday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.saturday.add(exercise);
          });
        }
        break;
      case "sunday":
        final Exercise? exercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ExerciseSelectionScreen()));
        if (exercise != null) {
          setState(() {
            workout.sunday.add(exercise);
          });
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 7,
      initialIndex: widget.startingTab,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: nameTextController,
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          bottom: TabBar(tabs: <Widget>[
            Tab(
              child: Text(
                "Su",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "Mo",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "Tu",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "We",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "Th",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "Fr",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            Tab(
              child: Text(
                "Sa",
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
          ]),
        ),
        body: FutureBuilder(
          future: workoutFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              mapRecord(snapshot.data!);
              return TabBarView(children: <Widget>[
                ExerciseList(
                  exercises: workout.sunday,
                  updating: true,
                  // onAdd: () => onAdd(context, "sunday"),
                  // onDelete: () => onDelete("sunday"),
                  // updateDetails: () => updateDetails("sunday")
                ),
                ExerciseList(
                  exercises: workout.monday,
                  updating: true,
                  // onAdd: () => onAdd(context, "monday"),
                  // onDelete: () => onDelete("monday"),
                  // updateDetails: () => updateDetails("monday")
                ),
                ExerciseList(
                  exercises: workout.tuesday,
                  updating: true,
                  // onAdd: () => onAdd(context, "tuesday"),
                  // onDelete: () => onDelete("tuesday"),
                  // updateDetails: () => updateDetails("tuesday")
                ),
                ExerciseList(
                  exercises: workout.wednesday,
                  updating: true,
                  // onAdd: () => onAdd(context, "wednesday"),
                  // onDelete: () => onDelete("wednesday"),
                  // updateDetails: () => updateDetails("wednesday")
                ),
                ExerciseList(
                  exercises: workout.thursday,
                  updating: true,
                  // onAdd: () => onAdd(context, "thursday"),
                  // onDelete: () => onDelete("thursday"),
                  // updateDetails: () => updateDetails("thursday")
                ),
                ExerciseList(
                  exercises: workout.friday,
                  updating: true,
                  // onAdd: () => onAdd(context, "friday"),
                  // onDelete: () => onDelete("friday"),
                  // updateDetails: () => updateDetails("friday")
                ),
                ExerciseList(
                  exercises: workout.saturday,
                  updating: true,
                  // onAdd: () => onAdd(context, "saturday"),
                  // onDelete: () => onDelete("saturday"),
                  // updateDetails: () => updateDetails("saturday")
                ),
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            List<Map<String, dynamic>> sunday = [];
            List<Map<String, dynamic>> monday = [];
            List<Map<String, dynamic>> tuesday = [];
            List<Map<String, dynamic>> wednesday = [];
            List<Map<String, dynamic>> thursday = [];
            List<Map<String, dynamic>> friday = [];
            List<Map<String, dynamic>> saturday = [];
            for (var i = 0; i < workout.sunday.length; i++) {
              sunday.add(workout.sunday[i].toFirebase());
            }
            for (var i = 0; i < workout.monday.length; i++) {
              monday.add(workout.monday[i].toFirebase());
            }
            for (var i = 0; i < workout.tuesday.length; i++) {
              tuesday.add(workout.tuesday[i].toFirebase());
            }
            for (var i = 0; i < workout.wednesday.length; i++) {
              wednesday.add(workout.wednesday[i].toFirebase());
            }
            for (var i = 0; i < workout.thursday.length; i++) {
              thursday.add(workout.thursday[i].toFirebase());
            }
            for (var i = 0; i < workout.friday.length; i++) {
              friday.add(workout.friday[i].toFirebase());
            }
            for (var i = 0; i < workout.saturday.length; i++) {
              saturday.add(workout.saturday[i].toFirebase());
            }
            dbRef.doc(widget.id).update({
              "name": nameTextController.text,
              "creator": user?.email,
              "sunday": sunday,
              "monday": monday,
              "tuesday": tuesday,
              "wednesday": wednesday,
              "thursday": thursday,
              "friday": friday,
              "saturday": saturday,
              "usedBy": [
                {"email": user?.email, "isFav": true}
              ]
            });
          },
          heroTag: "saveBtn",
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
