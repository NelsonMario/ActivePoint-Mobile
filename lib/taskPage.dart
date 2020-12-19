import 'package:activepoint_frontend/customWidget/button/primaryButton.dart';
import 'package:activepoint_frontend/customWidget/cards/gradientCardView.dart';
import 'package:activepoint_frontend/model/takenTask.dart';
import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

class TaskPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTaskPageState();
  }
}

class _MyTaskPageState extends State<TaskPage>{

  TaskHTTP taskHttp = new TaskHTTP();

  showAlertDialog(BuildContext context, String title, String content) {

    Widget closeButton = FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        closeButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

//    double windowWidth = MediaQuery.of(context).size.height;
//    double windowHeight = MediaQuery.of(context).size.height;

    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Task",
                style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Color(0xff000000)
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder(
                    future: taskHttp.getTakenTask(),
                    builder: (BuildContext buildContext, AsyncSnapshot<List<TakenTask>> snapshot) {
                      if(snapshot.hasData){
                        List<TakenTask> takenTasks = snapshot.data;
                        return ListView(
                          children: takenTasks.map(
                                  (TakenTask takenTasks) => GestureDetector(
                                  onTap: (){
                                    print(takenTasks.task.taskName);
                                    showModalBottomSheet(context: context, builder: (context){
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Text(takenTasks.task.taskName,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Nunito",
                                                  fontSize: 30
                                                ),
                                              ),
                                              width: 200,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: secondaryColor,
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.notifications,
                                                    color: secondaryColor,
                                                  ),
                                                  Text(takenTasks.status,
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.textsms,
                                                    color: secondaryColor,
                                                  ),
                                                  Text(takenTasks.task.description,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize:18
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: secondaryColor,
                                                  ),
                                                  Text(takenTasks.task.rewardPoint.toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: secondaryColor,
                                                  ),
                                                  Text("Start Date : " + takenTasks.task.startDate,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.timer_off,
                                                    color: secondaryColor,
                                                  ),
                                                  Text("End Date : " + takenTasks.task.deadlineDate,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: "Nunito",
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                taskHttp.shareTask(takenTasks.id).then((value) => {
                                                  if(value){
                                                    showAlertDialog(context, "Success", "Collaboration has been shared")
                                                  }
                                                });
                                              },
                                             child: PrimaryButton("Shared Task"),
                                            )

                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).canvasColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(10),
                                            topRight: const Radius.circular(10)
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: GradientCardView(takenTasks.task.taskName, takenTasks.task.startDate, takenTasks.task.rewardPoint)
                              )
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
              ),
            ),
          ]
        ),
      ),
    );
  }


}
