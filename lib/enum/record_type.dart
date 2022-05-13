class RecordType {
  final String string;
  final int code;
  const RecordType._(this.string, this.code);

  static const training = RecordType._('training', 0);
  static const examination = RecordType._('examination', 1);

  static const values = [training, examination];

  static RecordType? parse(int value) {
    switch (value) {
      case 0:
        return RecordType.training;
      case 1:
        return RecordType.examination;
      default:
        return null;
    }
  }

  int get value => code;

  @override
  String toString() {
    return 'RecordType.$string';
  }
}
