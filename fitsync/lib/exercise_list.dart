import 'package:client/exercise_list_item.dart';
import 'package:client/workout.dart';
import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList(
      {super.key,
      required this.exercises,
      required this.updating,
      this.onAdd,
      this.onDelete,
      this.updateDetails});

  final List<Exercise> exercises;
  final bool updating;
  final Function()? onAdd;
  final Function(int index)? onDelete;
  final Function(int weight, int reps, int sets, int index)? updateDetails;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return ExerciseListItem(
                details: exercises[index].details!,
                reps: exercises[index].reps,
                sets: exercises[index].sets,
                mins: exercises[index].mins,
                weight: exercises[index].weight,
                onSelectionScreen: false,
                updating: updating,
                onDelete: (index) => onDelete?.call(index),
                updateDetails: (weight, reps, sets, index) =>
                    updateDetails?.call(weight, reps, sets, index),
                index: index,
              );
            }),
      ),
      floatingActionButton: updating
          ? FloatingActionButton(
              onPressed: () => onAdd!(),
              shape: const CircleBorder(),
              heroTag: "new exercise btn",
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
