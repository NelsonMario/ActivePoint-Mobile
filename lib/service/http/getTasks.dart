import 'dart:convert';
import 'package:activepoint_frontend/model/takenTask.dart';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/task.dart';
import 'package:http/http.dart';

class TaskHTTP{
  final String getTasksUrl = Endpoints.getTasksUrl;
  final String getTakenTaskUrl = Endpoints.getTakenTaskUrl;


  Future<List<Task>> getTasks() async{

    Response res = await get(getTasksUrl);

    if(res.statusCode == 200){

      List<dynamic> body = jsonDecode(res.body);

      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item)).toList();

      return tasks;
    } else{
      throw "Can't get tasks";
    }
  }

  Future<TakenTask> getTakenTask(String token) async{
    Response res = await get(getTakenTaskUrl, headers: {
      "Authorization": "Bearer " + token
    });

    if(res.statusCode == 200){
      var json = jsonDecode(res.body);

      return TakenTask.fromJson(json);
    }
  }



}



