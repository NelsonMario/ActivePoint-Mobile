import 'dart:convert';
import 'package:activepoint_frontend/service/http/endpoints.dart';
import 'package:activepoint_frontend/model/user.dart';
import 'package:http/http.dart';


class UserHttp{
  final String getUserUrl = Endpoints.getUserUrl;

  Future<User> getUser(String email, String password) async {
    Response res = await post(getUserUrl, body: {
      "email": email,
      "password": password
    });

    if(res.statusCode == 200){
      var user = jsonDecode(res.body);

      return User.fromJson(user);
    }else{
      print ("invalid Email or Password");
    }
  }

}