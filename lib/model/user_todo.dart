class UserTodo {
  UserTodo(this.targetTimes, this.targetDate, this.complete, this.actualTimes);

  final List targetTimes;
  final String targetDate;
  final bool complete;
  final List actualTimes;

  Map<String, dynamic> toJson() => {
        'target_times': targetTimes,
        'target_date': targetDate,
        'complete': complete,
        'actual_times': actualTimes,
      };

  UserTodo.fromJson(Map<String, dynamic> json)
      : targetTimes = json['target_times'],
        targetDate = json['target_date'],
        complete = json['complete'],
        actualTimes = json['actual_times'];
}
