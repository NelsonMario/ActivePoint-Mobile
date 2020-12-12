import 'package:activepoint_frontend/model/takenTask.dart';
import 'package:activepoint_frontend/model/task.dart';

class ShareTask{

  int id;
  int takenTaskId;
  String userId;
  String shareDate;
  int adminApproval;
  TakenTask takenTask;


  ShareTask({this.id, this.takenTaskId, this.userId, this.shareDate, this.adminApproval, this.takenTask});

  factory ShareTask.fromJson(Map<String, dynamic> json){
    return ShareTask(
        id: json['id'] as int,
        takenTaskId: json['taken_task_id'] as int,
        userId: json['user_id'],
        shareDate: json['share_date'],
        adminApproval: json['admin_approval'] as int,
        takenTask: TakenTask.fromJson(json['taken_task'])
    );
  }
}