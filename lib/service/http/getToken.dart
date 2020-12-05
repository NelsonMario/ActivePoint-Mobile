import 'dart:convert';
import 'dart:ffi';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TokenHttp{
  final String getTokenUrl = Endpoints.getTokenUrl;

  Future<String> getToken(String email, String password) async {
    Response res = await post(getTokenUrl, body: {
      "email": email,
      "password": password
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(res.statusCode == 200){

      var token = jsonDecode(res.body);

      prefs.setString("REQUEST_TOKEN", token["token"]);
      return token["token"] != null ? token["token"] : token["error"];
    }else{
      return "invalid";
    }
  }

  Future<String> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("REQUEST_TOKEN");
    return token;
  }

  deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}