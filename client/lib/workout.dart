class Workout {
  Workout(
      {required this.id,
      required this.name,
      required this.creator,
      required this.usedBy,
      required this.monday,
      required this.tuesday,
      required this.wednesday,
      required this.thursday,
      required this.friday,
      required this.saturday,
      required this.sunday,
      this.usedByIndex,
      required this.usedByCurrentUser});

  String id, name, creator;
  List<UserPreference> usedBy;
  int? usedByIndex;
  List<Exercise> monday, tuesday, wednesday, thursday, friday, saturday, sunday;
  bool usedByCurrentUser;
}

class UserPreference {
  UserPreference({required this.email, required this.isFav});
  String email;
  bool isFav;
}

class Exercise {
  Exercise({this.details, this.reps, this.sets, this.weight, this.mins});
  ExerciseDetails? details;
  int? reps, sets, weight, mins;
}

class ExerciseDetails {
  ExerciseDetails(
      {required this.name,
      this.difficulty,
      this.equipment,
      this.instructions,
      this.muscle,
      this.type});

  String name;
  String? type, muscle, equipment, difficulty, instructions;
}
