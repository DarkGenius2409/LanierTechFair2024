import 'package:client/exercise_view.dart';
import 'package:client/workout.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExerciseListItem extends StatefulWidget {
  ExerciseListItem(
      {super.key,
      required this.details,
      this.mins,
      this.reps,
      this.sets,
      this.weight,
      this.onAdd,
      this.onDelete,
      this.updateDetails,
      required this.onSelectionScreen,
      required this.updating,
      required this.index});

  final ExerciseDetails details;
  int? reps;
  int? sets;
  int? mins;
  int? weight;
  int index;
  final bool onSelectionScreen;
  final bool updating;
  final Function()? onAdd;
  final Function(int index)? onDelete;
  final Function(int weight, int reps, int sets, int index)? updateDetails;

  @override
  State<ExerciseListItem> createState() => _ExerciseListItemState();
}

class _ExerciseListItemState extends State<ExerciseListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getTrailing(context) {
    if (widget.onSelectionScreen) {
      return IconButton(onPressed: widget.onAdd, icon: const Icon(Icons.add));
    } else {
      return Text(
          "${widget.weight != null ? "${widget.weight} lbs, " : " lbs,"} ${widget.reps != null ? "${widget.reps} reps, " : "0 reps,"} ${widget.sets != null ? "${widget.sets} sets, " : "0 sets,"}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.details.name),
      subtitle: Text("${widget.details.muscle} - ${widget.details.equipment}"),
      leading: Image.network(widget.details.img),
      trailing: getTrailing(context),
      onTap: () async {
        Exercise? updatedExercise = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExerciseView(
                    exercise: Exercise(
                        details: widget.details,
                        reps: widget.reps,
                        sets: widget.sets,
                        weight: widget.weight),
                    onDelete: (index) => widget.onDelete?.call(index),
                    updating: widget.updating,
                    index: widget.index)));

        setState(() {
          if (updatedExercise != null) {
            widget.weight = updatedExercise.weight;
            widget.reps = updatedExercise.reps;
            widget.sets = updatedExercise.sets;
            widget.updateDetails?.call(
                widget.weight!, widget.reps!, widget.sets!, widget.index);
          }
        });
      },
    );
  }
}
