import 'dart:convert';

import 'package:activepoint_frontend/homePage.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:activepoint_frontend/service/http/getUser.dart';
import 'package:activepoint_frontend/utils/credentialConstants.dart';
import 'package:flutter/material.dart';
import 'package:activepoint_frontend/customWidget/button/secondaryButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './customWidget/button/primaryButton.dart';
import 'customWidget/button/editTextWithIcon.dart';

class LoginForm extends StatelessWidget {

  final UserHttp userHttp = new UserHttp();
  final TokenHttp tokenHttp = new TokenHttp();
  final double _loginOffset ;
  final Function(int) changeState;

  final receiveEmailController = TextEditingController();
  final receivePasswordController = TextEditingController();

  LoginForm(this._loginOffset, this.changeState);


  Widget build(BuildContext context) {

    var token = "";
    _navigateToHomePage(){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return HomePage();
      }));
    }


    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(0, _loginOffset, 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        )
      ),
      child: Column(
        children: [
          Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text("Login to Continue", style: TextStyle(
                      fontSize: 20
                    )),
                  ),

                  EditTextWithIcon("Email", Icons.email, receiveEmailController, false),
                  EditTextWithIcon("Password", Icons.vpn_key, receivePasswordController, true),
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: (){
                      tokenHttp.getToken(receiveEmailController.text, receivePasswordController.text).then((value) => {
                        token = value,
                        setUserToSF(receiveEmailController.text, receivePasswordController.text, token),
                        print(token)
                      }).catchError((e) => print("error")).whenComplete(() => {
                        userHttp.getUser(receiveEmailController.text, receivePasswordController.text, token).then((value) => {
                          print(value),
                          if(value != null){
                            _navigateToHomePage(),
                          }
                        })
                      });
                    },
                      child: PrimaryButton('Login')
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      changeState(0);
                    },
                      child: SecondaryButton('Back')
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}

setUserToSF(String email, String password, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('EMAIL', email);
  prefs.setString('PASSWORD', password);
  prefs.setString('REQUEST_TOKEN', token);
}





    