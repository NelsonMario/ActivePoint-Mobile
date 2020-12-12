import 'dart:convert';

import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/reward.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:http/http.dart';

class RewardHTTP{
  final String getRewardUrl = Endpoints.getRewardUrl;
  final String insertRewardUrl = Endpoints.insertRewardUrl;

  Future<List<Reward>> getRewards() async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response  res = await get(getRewardUrl, headers: {
      "Authorization": "Bearer " + token
    });

    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);

      List<Reward> rewards = body.map((dynamic item) => Reward.fromJson(item)).toList();
      print("asdasd" + rewards.toString());
      return rewards;
    }else{
      throw "Can't get rewards";
    }
  }

  Future<bool> insertReward(int id) async{

    TokenHttp tokenHttp = new TokenHttp();

    String token = await tokenHttp.readToken();

    Response res = await post(insertRewardUrl, headers: {
      "Authorization": "Bearer " + token,
      },body: {
        "reward_id": id.toString()
      }
    );
    if(res.statusCode == 200){

      if(json.decode(res.body)["message"] == "fail to take reward") {
        return false;
      }
      return true;
    } else{
      return false;
    }
  }


}