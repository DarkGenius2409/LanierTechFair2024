import 'package:client/exercise_selection_screen.dart';
import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'exercise_list.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class NewWorkoutView extends StatefulWidget {
  NewWorkoutView({super.key, this.workout});

  Workout? workout;

  @override
  State<NewWorkoutView> createState() => _NewWorkoutViewState();
}

class _NewWorkoutViewState extends State<NewWorkoutView> {
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  final user = FirebaseAuth.instance.currentUser;
  late Workout workout;
  final nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    workout = widget.workout ??
        Workout(
            id: uuid.v4(),
            name: "",
            creator: user!.email ?? "Anonymous",
            usedBy: [],
            monday: [],
            tuesday: [],
            wednesday: [],
            thursday: [],
            friday: [],
            saturday: [],
            sunday: [],
            usedByCurrentUser: true);
    nameTextController.text = workout.name;
    // fetchRecord();
  }

  // fetchRecord() async {
  //   var record = await dbRef.doc(widget.id!).get();
  //   mapRecord(record);
  // }
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

  updateDetails(BuildContext context, String day, int weight, int reps,
      int sets, int index) async {
    switch (day) {
      case "monday":
        setState(() {
          workout.monday[index].weight = weight;
          workout.monday[index].reps = reps;
          workout.monday[index].sets = sets;
        });
        break;
      case "tuesday":
        setState(() {
          workout.tuesday[index].weight = weight;
          workout.tuesday[index].reps = reps;
          workout.tuesday[index].sets = sets;
        });
        break;
      case "wednesday":
        setState(() {
          workout.wednesday[index].weight = weight;
          workout.wednesday[index].reps = reps;
          workout.wednesday[index].sets = sets;
        });
        break;
      case "thursday":
        setState(() {
          workout.thursday[index].weight = weight;
          workout.thursday[index].reps = reps;
          workout.thursday[index].sets = sets;
        });
        break;
      case "friday":
        setState(() {
          workout.friday[index].weight = weight;
          workout.friday[index].reps = reps;
          workout.friday[index].sets = sets;
        });
        break;
      case "saturday":
        setState(() {
          workout.saturday[index].weight = weight;
          workout.saturday[index].reps = reps;
          workout.saturday[index].sets = sets;
        });
        break;
      case "sunday":
        setState(() {
          workout.sunday[index].weight = weight;
          workout.sunday[index].reps = reps;
          workout.sunday[index].sets = sets;
        });
        break;
      default:
    }
  }

  onDelete(BuildContext context, String day, int? index) async {
    switch (day) {
      case "monday":
        if (index != null) {
          setState(() {
            workout.monday.removeAt(index);
          });
        }
        break;
      case "tuesday":
        if (index != null) {
          setState(() {
            workout.tuesday.removeAt(index);
          });
        }
        break;
      case "wednesday":
        if (index != null) {
          setState(() {
            workout.wednesday.removeAt(index);
          });
        }
        break;
      case "thursday":
        if (index != null) {
          setState(() {
            workout.thursday.removeAt(index);
          });
        }
        break;
      case "friday":
        if (index != null) {
          setState(() {
            workout.friday.removeAt(index);
          });
        }
        break;
      case "saturday":
        if (index != null) {
          setState(() {
            workout.saturday.removeAt(index);
          });
        }
        break;
      case "sunday":
        if (index != null) {
          setState(() {
            workout.sunday.removeAt(index);
          });
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.height,
        child: DefaultTabController(
          length: 7,
          child: Scaffold(
            appBar: AppBar(
              title: TextFormField(
                controller: nameTextController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Name',
                  labelStyle: TextStyle(
                      color: widget.workout != null
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onBackground),
                ),
                style: TextStyle(
                    color: widget.workout != null
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onBackground),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  child: Text(
                    "Su",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "Mo",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "Tu",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "We",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "Th",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "Fr",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sa",
                    style: TextStyle(
                        color: widget.workout != null
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                  ),
                ),
              ]),
              backgroundColor: widget.workout != null
                  ? theme.colorScheme.primary
                  : theme.colorScheme.background,
              foregroundColor: widget.workout != null
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onBackground,
            ),
            body: TabBarView(children: <Widget>[
              ExerciseList(
                exercises: workout.sunday,
                updating: true,
                onAdd: () => onAdd(context, "sunday"),
                onDelete: (index) => onDelete(context, "sunday", index),
                updateDetails: (weight, reps, sets, index) =>
                    updateDetails(context, "sunday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.monday,
                updating: true,
                onAdd: () => onAdd(context, "monday"),
                onDelete: (index) => onDelete(context, "monday", index),
                updateDetails: (weight, reps, sets, index) =>
                    updateDetails(context, "monday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.tuesday,
                updating: true,
                onAdd: () => onAdd(context, "tuesday"),
                onDelete: (index) => onDelete(context, "tuesday", index),
                updateDetails: (weight, reps, sets, index) => updateDetails(
                    context, "tuesday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.wednesday,
                updating: true,
                onAdd: () => onAdd(context, "wednesday"),
                onDelete: (index) => onDelete(context, "wednesday", index),
                updateDetails: (weight, reps, sets, index) => updateDetails(
                    context, "wednesday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.thursday,
                updating: true,
                onAdd: () => onAdd(context, "thursday"),
                onDelete: (index) => onDelete(context, "thursday", index),
                updateDetails: (weight, reps, sets, index) => updateDetails(
                    context, "thursday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.friday,
                updating: true,
                onAdd: () => onAdd(context, "friday"),
                onDelete: (index) => onDelete(context, "friday", index),
                updateDetails: (weight, reps, sets, index) =>
                    updateDetails(context, "friday", weight, reps, sets, index),
              ),
              ExerciseList(
                exercises: workout.saturday,
                updating: true,
                onAdd: () => onAdd(context, "saturday"),
                onDelete: (index) => onDelete(context, "saturday", index),
                updateDetails: (weight, reps, sets, index) => updateDetails(
                    context, "saturday", weight, reps, sets, index),
              ),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (nameTextController.text.isNotEmpty) {
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

                  dbRef.doc(workout.id).set({
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
                  if (widget.workout != null) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Icon(Icons.check),
            ),
          ),
        ));
  }
}
