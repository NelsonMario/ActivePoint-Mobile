import 'package:activepoint_frontend/model/task.dart';

class TakenTask{

  int id;
  int taskId;
  int userId;
  String status;
  String takeDate;
  Task task;


  TakenTask({this.id, this.taskId, this.userId, this.status, this.takeDate, this.task});

  factory TakenTask.fromJson(Map<String, dynamic> json){
    return TakenTask(
      id: json['id'] as int,
      taskId: json['task_id'] as int,
      userId: json['user_id'] as int,
      status: json['status'] as String,
      takeDate: json['take_date'] as String,
      task: Task.fromJson(json['task'])
    );
  }
}