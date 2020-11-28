import 'package:activepoint_frontend/profilePage.dart';
import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:activepoint_frontend/availableTaskView.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';

import 'model/takenTask.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<Dashboard> {

  final TaskHTTP taskHttp = new TaskHTTP();
  int completeStatus = 0;
  int onGoingStatus = 0;

  _navigateToProfilePage(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return ProfilePage();
    }));
  }

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
                children:  [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                        "Jobs\nDashboard",
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
                    /*
                    * Do some calculation for task progress bar
                    * */
                    value: completeStatus == 0 ? 0 : completeStatus / completeStatus + onGoingStatus,
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
                builder: (BuildContext bc, AsyncSnapshot<List<TakenTask>> snapshot){
                  if(snapshot.hasData){
                    List<TakenTask> takenTask = snapshot.data;

                    /*
                    * Check the status of task
                    * */

                    onGoingStatus = 0;
                    completeStatus = 0;

                    takenTask.forEach((element) {
                      if (element.status == "ongoing")
                        onGoingStatus++;
                      else if(element.status == "complete")
                        completeStatus++;
                    });

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildInfo(onGoingStatus, "On Going task"),
                        SizedBox(width: 10,),
                        buildInfo(completeStatus, "Completed Task"),
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
              child: AvailableTaskView(),
            )
          ],
        ),
      )
    );
  }
}






