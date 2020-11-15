class Task{
  int id;
  String taskName;
  String description;
  int rewardPoint;
  int slot;
  String startDate;
  String deadlineDate;

  Task({this.id, this.taskName, this.description, this.rewardPoint, this.startDate, this.deadlineDate, this.slot});

  factory Task.fromJson(dynamic json){
    return Task(
      id: json['id'] as int,
      taskName: json['task_name'],
      description: json['description'],
      rewardPoint: json['reward_point'],
      slot: json['slot'],
      startDate: json["start_date"],
      deadlineDate: json["deadline_date"]
    );
  }
}