class TrainingPart {
  final String string;
  final int code;
  const TrainingPart._(this.string, this.code);

  ///二頭肌
  static const biceps = TrainingPart._('biceps', 0);

  ///三角肌
  static const deltoid = TrainingPart._('deltoid', 1);

  ///股四頭肌
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
        throw Exception("Invalid TrainingPart value");
    }
  }

  int get value => code;

  @override
  String toString() {
    return 'TrainingPart.$string';
  }
}
