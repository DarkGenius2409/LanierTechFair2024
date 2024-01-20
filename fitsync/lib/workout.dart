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
  Exercise({
    this.details,
    this.reps,
    this.sets,
    this.weight,
    this.mins,
  });
  ExerciseDetails? details;
  int? reps, sets, weight, mins;

  Map<String, dynamic> toFirebase() {
    return {
      "reps": reps,
      "sets": sets,
      "weight": weight,
      "mins": mins,
      "details": details?.toFirebase()
    };
  }
}

class ExerciseDetails {
  ExerciseDetails(
      {required this.name,
      this.difficulty,
      this.equipment,
      this.instructions,
      this.muscle,
      this.type,
      required this.img});

  String name, img;
  String? type, muscle, equipment, difficulty;
  List<dynamic>? instructions;

  Map<String, dynamic> toFirebase() {
    return {
      "name": name,
      "img": img,
      "type": type,
      "muscle": muscle,
      "equipment": equipment,
      "difficulty": difficulty,
      "instructions": instructions
    };
  }
}

enum EquipmentFilter {
  assisted,
  band,
  barbell,
  bodyWeight,
  bosuBall,
  cable,
  dumbbell,
  ellipticalMachine,
  ezBarbell,
  hammer,
  kettlebell,
  leverageMachine,
  medicineBall,
  olympicBarbell,
  resistanceBand,
  roller,
  rope,
  skiergMachine,
  sledMachine,
  smithMachine,
  stabilityBall,
  stationaryBike,
  stepmillMachine,
  tire,
  trapBar,
  upperBodyErgometer,
  weighted,
  wheelRoller
}

enum TargetFilter {
  abductors,
  abs,
  adductors,
  biceps,
  calves,
  cardio,
  delts,
  forearms,
  glutes,
  hamstrings,
  lats,
  levatorScapulae,
  pectorals,
  quads,
  serratusAnterior,
  spine,
  traps,
  triceps,
  upperBack
}
