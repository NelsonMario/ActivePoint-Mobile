import 'dart:convert';

import 'package:activepoint_frontend/model/scoreboard.dart';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:http/http.dart';

class ScoreboardHttp{
  final String getScoreboardUrl = Endpoints.getScoreboardUrl;

  Future<List<Scoreboard>> getScoreboards() async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response  res = await get(getScoreboardUrl, headers: {
      "Authorization": "Bearer " + token
    });
    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);
      List<Scoreboard> scoreboard = body.map((dynamic item) => Scoreboard.fromJson(item)).toList();
      print(scoreboard);
      return scoreboard;
    }else{
      throw "Can't get scoreboards";
    }
  }
}