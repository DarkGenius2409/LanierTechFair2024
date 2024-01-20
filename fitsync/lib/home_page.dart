import 'package:client/exercise_list.dart';
import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [TitleSection()],
        ),
      ),
    );
  }
}

class TitleSection extends StatefulWidget {
  const TitleSection({super.key});

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  Workout? workout;
  final dbRef = FirebaseFirestore.instance.collection("workouts");
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _workoutStream;
  final user = FirebaseAuth.instance.currentUser;
  late String username;
  late Future<String?> _workoutIDFuture;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    username = user?.displayName ?? "";
    _workoutIDFuture = findCurrentWorkout();
  }

  Future<String?> findCurrentWorkout() async {
    QuerySnapshot<Map<String, dynamic>> records = await dbRef.get();
    for (var i = 0; i < records.docs.length; i++) {
      var doc = records.docs[i];
      for (var j = 0; j < doc["usedBy"].length; j++) {
        if (doc["usedBy"][j]["email"] == user?.email) {
          if (doc["usedBy"][j]["isFav"]) {
            return doc.id;
          }
        }
      }
    }
    return null;
  }

  void mapRecords(DocumentSnapshot<Map<String, dynamic>> doc) {
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
      if ((doc["usedBy"][j]["email"] == user?.email)) {
        usedByCurrentUser = true;
      }
      usedBy.add(UserPreference(
          email: doc["usedBy"][j]["email"], isFav: doc["usedBy"][j]["isFav"]));
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
        usedByCurrentUser: usedByCurrentUser);
  }

  Widget currentWorkout() {
    int date = DateTime.now().weekday;
    switch (date) {
      case 1:
        return ExerciseList(
          exercises: workout!.monday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 2:
        return ExerciseList(
          exercises: workout!.tuesday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 3:
        return ExerciseList(
          exercises: workout!.wednesday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 4:
        return ExerciseList(
          exercises: workout!.thursday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 5:
        return ExerciseList(
          exercises: workout!.friday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 6:
        return ExerciseList(
          exercises: workout!.saturday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      case 7:
        return ExerciseList(
          exercises: workout!.sunday,
          updating: false,
          onAdd: () {},
          onDelete: (index) {},
          updateDetails: (weight, reps, sets, index) {},
        );
      default:
        return const Text("You do not have a workout today");
    }
  }

  void printText(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double usernamePadding = screenSize.height * 0.05;
    final double paddingTop = screenSize.height * 0.05;
    final double paddingX = screenSize.width * 0.1;
    final double dividerIndent = screenSize.width * 0.01;

    return FutureBuilder(
        future: _workoutIDFuture,
        builder: (context, snapshot) {
          _workoutStream = dbRef.doc(snapshot.data).snapshots();
          return StreamBuilder(
              stream: _workoutStream,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  mapRecords(
                      snapshot.data as DocumentSnapshot<Map<String, dynamic>>);
                } else {
                  return const Center(
                    child: Text("You don't have any programs set up!"),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(
                      top: paddingTop, left: paddingX, right: paddingX),
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                        "Welcome",
                        style: TextStyle(fontSize: 60),
                      )),
                      Padding(
                        padding: EdgeInsets.only(bottom: usernamePadding),
                        child: Center(
                            child: Text(
                          username,
                          style: const TextStyle(fontSize: 40),
                        )),
                      ),
                      Divider(
                        indent: dividerIndent,
                        endIndent: dividerIndent,
                      ),
                      // currentWorkout(),
                      //
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.01),
                        child: const Text(
                          "Today's Workout",
                          style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                          height: screenSize.height * 0.7,
                          width: screenSize.height * 0.85,
                          child: currentWorkout())
                    ],
                  ),
                );
              });
        });
  }
}
