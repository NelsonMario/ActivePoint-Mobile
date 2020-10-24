import 'dart:convert';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/task.dart';
import 'package:http/http.dart';

class TaskHTTP{
  final String getTasksUrl = Endpoints.getTasksUrl;

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
}