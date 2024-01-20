import 'package:client/workout.dart';
import 'package:flutter/material.dart';

class ExerciseView extends StatefulWidget {
  ExerciseView(
      {super.key,
      required this.exercise,
      this.onDelete,
      required this.updating,
      required this.index});

  Exercise exercise;
  Function(int index)? onDelete;
  bool updating;
  int index;

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  late TextEditingController weightsController = TextEditingController();
  late TextEditingController repsController = TextEditingController();
  late TextEditingController setsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repsController.text = widget.exercise.reps.toString();
    setsController.text = widget.exercise.sets.toString();
    weightsController.text = widget.exercise.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.details!.name),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Image.network(
              widget.exercise.details!.img,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
              child: Column(children: [
                TextFormField(
                  controller: weightsController,
                  enabled: widget.updating ? true : false,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Weight',
                    labelStyle:
                        TextStyle(color: theme.colorScheme.onBackground),
                  ),
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: repsController,
                  enabled: widget.updating ? true : false,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Reps',
                    labelStyle:
                        TextStyle(color: theme.colorScheme.onBackground),
                  ),
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: setsController,
                  enabled: widget.updating ? true : false,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Sets',
                    labelStyle:
                        TextStyle(color: theme.colorScheme.onBackground),
                  ),
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )
              ]),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: Text(
                  "Instructions: ",
                  style: TextStyle(fontSize: size.width * 0.07),
                )),
            widget.exercise.details!.instructions != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                    ),
                    child: SizedBox(
                      height: 300,
                      width: size.width * 0.9,
                      child: ListView.builder(
                          itemCount:
                              widget.exercise.details!.instructions!.length,
                          itemBuilder: (context, index) {
                            return Text(
                                "${index + 1}. ${widget.exercise.details!.instructions![index]}\n");
                          }),
                    ),
                  )
                : const Text(
                    "Sorry, we don't have instructions for this exercise"),
            widget.updating
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.1),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: ElevatedButton(
                              onPressed: () {
                                widget.exercise.weight =
                                    int.parse(weightsController.text);
                                widget.exercise.reps =
                                    int.parse(repsController.text);
                                widget.exercise.sets =
                                    int.parse(setsController.text);
                                Navigator.pop(context, widget.exercise);
                              },
                              child: const Text("Save"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: ElevatedButton(
                                onPressed: () {
                                  widget.onDelete?.call(widget.index);
                                  // Navigator.pop(context);
                                },
                                child: const Text("Remove")),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("OK")),
                  )
          ]),
        ),
      ),
    );
  }
}
