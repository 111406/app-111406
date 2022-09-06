class Target {
  Target(this.userId, this.startDate, this.endDate, this.userTodoList);

  final String userId;
  final String startDate;
  final String endDate;
  final List userTodoList;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'start_date': startDate,
        'end_date': endDate,
        'user_todos': userTodoList,
      };

  Target.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        userTodoList = json['userTodoList'];
}
