import 'package:sport_app/enum/training_part.dart';

class Record {
  final String? userId;
  final TrainingPart? part;
  final int? times;
  final int? fails;
  final String? testResult;
  final int? pr;
  final int? createTime;
  final int? difference;

  Record(
      {this.userId,
      this.part,
      this.times,
      this.fails,
      this.testResult,
      this.pr,
      this.createTime,
      this.difference});

  Map toJson() => {
        'userId': userId,
        'part': part!.value,
        'times': times,
        'fails': fails,
        'testResult': testResult,
        'pr': pr,
        'createTime': createTime,
      };

  Record.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        part = TrainingPart.parse(json['part']),
        times = json['times'],
        fails = json['fails'],
        testResult = json['test_result'],
        pr = json['pr'],
        createTime = json['create_time'],
        difference = json['difference'];
}
