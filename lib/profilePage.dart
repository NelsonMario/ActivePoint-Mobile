import 'package:activepoint_frontend/customWidget/button/secondaryButton.dart';
import 'package:activepoint_frontend/model/scoreboard.dart';
import 'package:activepoint_frontend/model/user.dart';
import 'package:activepoint_frontend/service/http/getScoreboard.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:activepoint_frontend/service/http/getUser.dart';
import 'package:activepoint_frontend/utils/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TokenHttp tokenHttp = new TokenHttp();
    UserHttp userHttp = new UserHttp();
    ScoreboardHttp scoreboardHttp = new ScoreboardHttp();

    return Container (
      child: FutureBuilder(
        future: userHttp.getUserFromSF(),
        builder: (BuildContext bc, AsyncSnapshot<User> snapshot){
          if(snapshot.hasData){
            User user = snapshot.data;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60.0),
                  child:  Image.network('https://laboratory.binus.ac.id/lapi/api/Account/GetThumbnail?id='+user.pictureId),
                ),
                SizedBox(height: 10,),
                Text(user.name, style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xff000000)
                )),
                SizedBox(height: 10,),
                Text("Point : " + user.point.toString(), style: TextStyle(
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xff000000)
                )),
                SizedBox(height: 40,),
                Container(
                  child: Text('Scoreboard',
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
                SizedBox(height: 40,),
                FutureBuilder(
                  future: scoreboardHttp.getScoreboards(),
                  builder: (BuildContext buildContext, AsyncSnapshot<List<Scoreboard>> snapshot){
                    if (snapshot.hasData){
                      List<Scoreboard> scoreboards = snapshot.data;
                      return Expanded(
                        child: Center(
                          child: ListView(
                            children: scoreboards.map(
                                    (Scoreboard scoreboard) => Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(scoreboard.name.toString(), style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xff000000)
                                    ), textAlign: TextAlign.center,),
                                    Text(scoreboard.point.toString(), style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xff000000)
                                    ), textAlign: TextAlign.center),
                                  ],
                                )).toList(),
                          ),
                        ),
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
                GestureDetector(
                    onTap: (){
                      tokenHttp.deleteToken();
                      SystemNavigator.pop();
                    },
                    child: SecondaryButton("Logout")
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}


