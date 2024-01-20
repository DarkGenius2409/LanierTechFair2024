import 'dart:convert';

import 'package:client/exercise_list_item.dart';
import 'package:client/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen({super.key});

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen>
    with TickerProviderStateMixin {
  late Future<List<Exercise>> futureExercises;
  List<Exercise> exercises = [];
  int index = 0;
  bool tabFirstTime = true;
  List<String> targetFilters = [];
  List<String> equipmentFilters = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _tabController = TabController(
    //   length: tabs.length,
    //   initialIndex: 0,
    //   vsync: this,
    // );
    // _tabController!.addListener(_handleTabSelection);
    futureExercises = fetchExercises();
  }

  // void _handleTabSelection() {
  //   if (_tabController!.indexIsChanging) {
  //     switch (_tabController!.index) {
  //       case 0:
  //         break;
  //       case 1:
  //         break;
  //       case 2:
  //         break;
  //     }
  //   }
  // }

  void _loadMoreData() async {
    List<Exercise> newExercises = [];
    if (!tabFirstTime) {
      for (var i = 0; i < targetFilters.length; i++) {
        final response = await http.get(
            Uri.parse(
                'https://exercisedb.p.rapidapi.com/exercises/target/${targetFilters[i]}?limit=10&offset=${10 * index}'),
            headers: {
              "X-RapidAPI-Key":
                  "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
              "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
            });

        final responseJson = jsonDecode(response.body) as List<dynamic>;

        for (var i = 0; i < responseJson.length; i++) {
          Map<String, dynamic> rawExercise = responseJson[i];
          ExerciseDetails details = ExerciseDetails(
              name: rawExercise["name"],
              img: rawExercise["gifUrl"],
              muscle: rawExercise["target"],
              equipment: rawExercise["equipment"],
              instructions: rawExercise["instructions"]);
          var exercise =
              Exercise(details: details, weight: 0, reps: 0, sets: 0);
          // if (checkDuplicate(exercise)) {
          //   newExercises.add(exercise);
          // }
          newExercises.add(exercise);
        }
      }
      for (var i = 0; i < equipmentFilters.length; i++) {
        final response = await http.get(
            Uri.parse(
                'https://exercisedb.p.rapidapi.com/exercises/equipment/${equipmentFilters[i]}?limit=10&offset=${10 * index}'),
            headers: {
              "X-RapidAPI-Key":
                  "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
              "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
            });

        final responseJson = jsonDecode(response.body) as List<dynamic>;

        for (var i = 0; i < responseJson.length; i++) {
          Map<String, dynamic> rawExercise = responseJson[i];
          ExerciseDetails details = ExerciseDetails(
              name: rawExercise["name"],
              img: rawExercise["gifUrl"],
              muscle: rawExercise["target"],
              equipment: rawExercise["equipment"],
              instructions: rawExercise["instructions"]);
          var exercise =
              Exercise(details: details, weight: 0, reps: 0, sets: 0);
          // if (checkDuplicate(exercise)) {
          //   newExercises.add(exercise);
          // }
          newExercises.add(exercise);
        }
      }
    } else {
      final response = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises?limit=10&offset=${10 * index}'),
          headers: {
            "X-RapidAPI-Key":
                "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
          });

      final responseJson = jsonDecode(response.body) as List<dynamic>;

      for (var i = 0; i < responseJson.length; i++) {
        Map<String, dynamic> rawExercise = responseJson[i];
        ExerciseDetails details = ExerciseDetails(
            name: rawExercise["name"],
            img: rawExercise["gifUrl"],
            muscle: rawExercise["target"],
            equipment: rawExercise["equipment"],
            instructions: rawExercise["instructions"]);
        var exercise = Exercise(details: details, weight: 0, reps: 0, sets: 0);
        // if (checkDuplicate(exercise)) {
        //   newExercises.add(exercise);
        // }
        newExercises.add(exercise);
      }
    }

    setState(() {
      exercises.addAll(newExercises);
      exercises.shuffle();
    });
  }

  Future<List<Exercise>> fetchExercises() async {
    List<Exercise> newExercises = [];
    final response = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises?limit=10'),
        headers: {
          "X-RapidAPI-Key":
              "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
          "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        });

    final responseJson = jsonDecode(response.body) as List<dynamic>;

    for (var i = 0; i < responseJson.length; i++) {
      Map<String, dynamic> exercise = responseJson[i];
      ExerciseDetails details = ExerciseDetails(
          name: exercise["name"],
          img: exercise["gifUrl"],
          muscle: exercise["target"],
          equipment: exercise["equipment"],
          instructions: exercise["instructions"]);
      newExercises.add(Exercise(details: details, weight: 0, reps: 0, sets: 0));
    }

    return newExercises;
  }

  bool checkDuplicate(Exercise exercise) {
    for (var i = 0; i < exercises.length; i++) {
      if (exercises[i].details?.name == exercise.details?.name) {
        return true;
      }
    }
    return false;
  }

  void fetchFilteredExercises() async {
    List<Exercise> newExercises = [];
    for (var i = 0; i < targetFilters.length; i++) {
      final response = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises/target/${targetFilters[i]}?limit=10'),
          headers: {
            "X-RapidAPI-Key":
                "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
          });

      final responseJson = jsonDecode(response.body) as List<dynamic>;

      for (var i = 0; i < responseJson.length; i++) {
        Map<String, dynamic> rawExercise = responseJson[i];
        ExerciseDetails details = ExerciseDetails(
            name: rawExercise["name"],
            img: rawExercise["gifUrl"],
            muscle: rawExercise["target"],
            equipment: rawExercise["equipment"],
            instructions: rawExercise["instructions"]);

        var exercise = Exercise(details: details, weight: 0, reps: 0, sets: 0);
        // if (checkDuplicate(exercise)) {
        //   newExercises.add(exercise);
        // }
        newExercises.add(exercise);
      }
    }

    for (var i = 0; i < equipmentFilters.length; i++) {
      final response = await http.get(
          Uri.parse(
              'https://exercisedb.p.rapidapi.com/exercises/equipment/${equipmentFilters[i]}?limit=10'),
          headers: {
            "X-RapidAPI-Key":
                "087f067f9amshfaa438e3f236736p172f68jsn889df7afef01",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
          });

      final responseJson = jsonDecode(response.body) as List<dynamic>;

      for (var i = 0; i < responseJson.length; i++) {
        Map<String, dynamic> rawExercise = responseJson[i];
        ExerciseDetails details = ExerciseDetails(
            name: rawExercise["name"],
            img: rawExercise["gifUrl"],
            muscle: rawExercise["target"],
            equipment: rawExercise["equipment"],
            instructions: rawExercise["instructions"]);

        var exercise = Exercise(details: details, weight: 0, reps: 0, sets: 0);
        // if (checkDuplicate(exercise)) {
        //   newExercises.add(exercise);
        // }
        newExercises.add(exercise);
      }
    }

    setState(() {
      exercises.addAll(newExercises);
      exercises.shuffle();
    });
  }

  String targetFilterToString(TargetFilter filter, bool api) {
    String filterText = filter.name;
    String outputText = "";
    for (var i = 0; i < filterText.length; i++) {
      String currentLetter = filterText.substring(i, i + 1);
      if (currentLetter.toUpperCase() == currentLetter) {
        outputText += "${api ? "%20" : " "}${currentLetter.toLowerCase()}";
      } else {
        outputText += currentLetter;
      }
    }
    return outputText;
  }

  String equipmentFilterToString(EquipmentFilter filter, bool api) {
    String filterText = filter.name;
    String outputText = "";
    for (var i = 0; i < filterText.length; i++) {
      String currentLetter = filterText.substring(i, i + 1);
      if (currentLetter.toUpperCase() == currentLetter) {
        outputText += "${api ? "%20" : " "}${currentLetter.toLowerCase()}";
      } else {
        outputText += currentLetter;
      }
    }
    return outputText;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Exercises"),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Builder(builder: (context) {
                  return OutlinedButton(
                      onPressed: () {
                        Scaffold.of(context).showBottomSheet((context) {
                          if (tabFirstTime) {
                            exercises.clear();
                          }
                          tabFirstTime = false;
                          return SizedBox(
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Target Muscle:",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 5.0,
                                        children: TargetFilter.values
                                            .map((TargetFilter target) {
                                          return FilterChip(
                                            label: Text(targetFilterToString(
                                                target, false)),
                                            selected: targetFilters.contains(
                                                targetFilterToString(
                                                    target, true)),
                                            onSelected: (bool selected) {
                                              setState(() {
                                                if (selected) {
                                                  targetFilters.add(
                                                      targetFilterToString(
                                                          target, true));
                                                  fetchFilteredExercises();
                                                } else {
                                                  targetFilters.remove(
                                                      targetFilterToString(
                                                          target, true));
                                                  fetchFilteredExercises();
                                                }
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Equipment:",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 5.0,
                                        children: EquipmentFilter.values
                                            .map((EquipmentFilter equipment) {
                                          return FilterChip(
                                            label: Text(equipmentFilterToString(
                                                equipment, false)),
                                            selected: equipmentFilters.contains(
                                                equipmentFilterToString(
                                                    equipment, true)),
                                            onSelected: (bool selected) {
                                              setState(() {
                                                if (selected) {
                                                  equipmentFilters.add(
                                                      equipmentFilterToString(
                                                          equipment, true));
                                                  fetchFilteredExercises();
                                                } else {
                                                  equipmentFilters.remove(
                                                      equipmentFilterToString(
                                                          equipment, true));
                                                  fetchFilteredExercises();
                                                }
                                              });
                                            },
                                          );
                                        }).toList(),
                                      ),
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("OK"))
                                    ]),
                                  ),
                                ),
                              ));
                        });
                      },
                      child: Text(
                        "Filter",
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ));
                }))
          ]),
      body: FutureBuilder(
        future: futureExercises,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            exercises = snapshot.data!;
            return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter == 0) {
                    index++;
                    _loadMoreData();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: exercises.length + 1,
                  itemBuilder: (context, index) {
                    if (index < exercises.length) {
                      return ExerciseListItem(
                          details: exercises[index].details!,
                          onSelectionScreen: true,
                          onAdd: () {
                            Navigator.pop(context, exercises[index]);
                          },
                          updating: false,
                          index: index);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    // By default, show a loading spinner.
                  },
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
