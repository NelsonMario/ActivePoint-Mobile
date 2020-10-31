import 'package:activepoint_frontend/customWidget/cards/gradientCardView.dart';
import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

class TaskView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTaskViewState();
  }
}

class _MyTaskViewState extends State<TaskView>{

  TaskHTTP taskHttp = new TaskHTTP();

  @override
  Widget build(BuildContext context) {

    double windowWidth = MediaQuery.of(context).size.height;
    double windowHeight = MediaQuery.of(context).size.height;

    return Container(
          child: FutureBuilder(
            future: taskHttp.getTasks(),
            builder: (BuildContext buildContext, AsyncSnapshot<List<Task>> snapshot) {
              if(snapshot.hasData){
                List<Task> tasks = snapshot.data;
                return ListView(
                  children: tasks.map(
                          (Task task) => GradientCardView(task.taskName, task.startDate,task.rewardPoint)
//                              ListTile(
//                        title: Text(task.taskName.toString()),
//                        subtitle: Text(task.description.toString()),
//                      )
                  ).toList(),

                );
              }
              return Center(child: CircularProgressIndicator());
            }
        ),
    );
  }


}
