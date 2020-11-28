import 'package:activepoint_frontend/customWidget/button/primaryButton.dart';
import 'package:activepoint_frontend/customWidget/cards/gradientCardView.dart';
import 'package:activepoint_frontend/service/http/getTasks.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

class AvailableTaskView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAvailableTaskViewState();
  }
}

class _MyAvailableTaskViewState extends State<AvailableTaskView>{

  TaskHTTP taskHttp = new TaskHTTP();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

//    double windowWidth = MediaQuery.of(context).size.height;
//    double windowHeight = MediaQuery.of(context).size.height;

    return Container(
          child: FutureBuilder(
            future: taskHttp.getTasks(),
            builder: (BuildContext buildContext, AsyncSnapshot<List<Task>> snapshot) {
              if(snapshot.hasData){
                List<Task> tasks = snapshot.data;
                return ListView(
                  children: tasks.map(
                          (Task task) => GestureDetector(
                              onTap: (){
                                print(task.taskName);
                                showModalBottomSheet(context: context, builder: (context){
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        _isLoading  ? Stack(
                                          children: <Widget>[
                                            Opacity(
                                              opacity: 0.3,
                                              child: ModalBarrier(
                                                dismissible: false,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ],
                                        ) : SizedBox(
                                          height: 0,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Text(task.taskName,
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
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.textsms,
                                                color: secondaryColor,
                                              ),
                                              Text(task.description,
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
                                              Text(task.rewardPoint.toString(),
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
                                              Text("Start Date : " + task.startDate,
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
                                              Text("End Date : " + task.deadlineDate,
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
                                          onTap: (){
                                            taskHttp.insertTask(task.id).then((value) => {
                                              setState(() {
                                                _isLoading = true;
                                              })
                                            });
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                          child: PrimaryButton("Take Task")
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
                              child: GradientCardView(task.taskName, task.startDate,task.rewardPoint)
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
    );
  }


}
