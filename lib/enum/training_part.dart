class TrainingPart {
  final String string;
  final int code;
  const TrainingPart._(this.string, this.code);

  static const biceps = TrainingPart._('biceps', 0);
  static const deltoid = TrainingPart._('deltoid', 1);
  static const quadriceps = TrainingPart._('quadriceps', 2);

  static const values = [biceps, deltoid, quadriceps];

  static TrainingPart? parse(int value) {
    switch (value) {
      case 0:
        return TrainingPart.biceps;
      case 1:
        return TrainingPart.deltoid;
      case 2:
        return TrainingPart.quadriceps;
      default:
        return null;
    }
  }

  int get value => code;

  @override
  String toString() {
    return 'TrainingPart.$string';
  }
}
