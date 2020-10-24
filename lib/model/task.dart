class Task{
  int id;
  String taskName;
  String description;
  int rewardPoint;
  String startDate;
  String deadlineDate;

  Task({this.id, this.taskName, this.description, this.rewardPoint, this.startDate, this.deadlineDate});

  factory Task.fromJson(dynamic json){
    return Task(
      id: json['id'] as int,
      taskName: json['task_name'],
      description: json['description'],
      rewardPoint: json['reward_point'],
      startDate: json["start_date"],
      deadlineDate: json["deadline_date"]
    );
  }
}