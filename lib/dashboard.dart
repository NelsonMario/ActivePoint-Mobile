import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:activepoint_frontend/taskView.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:activepoint_frontend/utils/credentialConstants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/takenTask.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<Dashboard> {

  final String _token = "";
  final TaskHTTP taskHttp = new TaskHTTP();
  int taken = 0;
  int unfinished = 0;


  @override
  Widget build(BuildContext context) {

    Column buildInfo(int countTasks, String title){
        return Column(
          children: [
            Text(
            countTasks.toString(),
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: Color(0xffffffff)
              ),
            ),
            Text(
            title,
            style: TextStyle(
              fontFamily: "Nunito",
              fontWeight: FontWeight.w900,
              fontSize: 12,
              color: Color(0xffffffff)
            ),
          )
        ]
      );
    }

    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Text(
                      "Jobs\nDashboard" + _token,
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: Color(0xff000000)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  LinearProgressIndicator(
                    value: taken == 0 ? 0 : taken - unfinished / taken,
                    backgroundColor: lightGrayColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "Profile Completeness",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff8d8d8d)
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 15
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: secondaryColor
              ),
              child: FutureBuilder(
                future: taskHttp.getTakenTask(),
                builder: (BuildContext bc, AsyncSnapshot<TakenTask> snapshot){
                  if(snapshot.hasData){
                    TakenTask takenTask = snapshot.data;

                    taken = takenTask.taken;
                    unfinished = takenTask.unfinished;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildInfo(taken, "Taken Task"),
                        SizedBox(width: 25,),
                        buildInfo(unfinished, "Unfinished Task")
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )
            ),
            SizedBox(height: 10,),
            Text("Available Task",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Color(0xff0000000)
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: TaskView(),
            )
          ],
        ),
      )
    );
  }
}






