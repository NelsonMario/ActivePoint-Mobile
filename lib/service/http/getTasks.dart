import 'dart:convert';
import 'package:activepoint_frontend/model/takenTask.dart';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/task.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:http/http.dart';

class TaskHTTP{
  final String getTasksUrl = Endpoints.getTasksUrl;
  final String getTakenTaskUrl = Endpoints.getTakenTaskUrl;
  final String insertTaskUrl = Endpoints.insertTaskUrl;



  Future<List<Task>> getTasks() async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response res = await get(getTasksUrl, headers: {
      "Authorization": "Bearer " + token
    });


    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);

      List<Task> tasks = body.map((dynamic item) => Task.fromJson(item)).toList();

      return tasks;
    } else{
      throw "Can't get tasks";
    }
  }

  Future<List<TakenTask>> getTakenTask() async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response res = await get(getTakenTaskUrl, headers: {
      "Authorization": "Bearer " + token
    });

    if(res.statusCode == 200){

      List<dynamic> body = jsonDecode(res.body);

      List<TakenTask> takenTasks = body.map((dynamic item) => TakenTask.fromJson(item)).toList();
      return takenTasks;
    }
  }

  Future<bool> insertTask(int id) async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response res = await post(insertTaskUrl, headers: {
      "Authorization": "Bearer " + token,
    },body: {
      "task_id": id.toString()
      }
    );

    print(id);
    print(res.body);

    if(res.statusCode == 200){
      return true;
    } else{
      return false;
    }
  }
}



