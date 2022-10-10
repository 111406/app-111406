class Gender {
  final String string;
  final int code;
  const Gender._(this.string, this.code);

  ///男性
  static const male = Gender._('男', 0);

  ///女性
  static const female = Gender._('女', 1);

  static const values = [male, female];

  static Gender parse(String value) {
    switch (value) {
      case "男":
        return Gender.male;
      default:
        return Gender.female;
    }
  }

  int get value => code;

  @override
  String toString() {
    return 'TrainingHand.$string';
  }
}
