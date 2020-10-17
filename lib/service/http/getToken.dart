import 'dart:convert';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class TokenHttp{
  final String getTokenUrl = Endpoints.getTokenUrl;

  Future<String> getToken(String email, String password) async {
    Response res = await post(getTokenUrl, body: {
      "email": email,
      "password": password
    });

    if(res.statusCode == 200){

      var token = jsonDecode(res.body);
      return token["token"] != null ? token["token"] : token["error"];
    }else{
      return "invalid";
    }
  }

}