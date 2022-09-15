class TrainingHand {
  final String string;
  final String code;
  const TrainingHand._(this.string, this.code);

  ///左手
  static const leftHand = TrainingHand._('左手', 'left');

  ///右手
  static const rightHand = TrainingHand._('右手', 'right');

  static const values = [leftHand, rightHand];

  static TrainingHand parse(String value) {
    switch (value) {
      case 'left':
        return TrainingHand.leftHand;
      default:
        return TrainingHand.rightHand;
    }
  }

  String get value => code;

  @override
  String toString() {
    return 'TrainingHand.$string';
  }
}
