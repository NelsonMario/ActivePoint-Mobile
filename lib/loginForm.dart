import 'package:activepoint_frontend/service/http/getUser.dart';
import 'package:flutter/material.dart';
import 'package:activepoint_frontend/customWidget/button/secondaryButton.dart';
import './customWidget/button/primaryButton.dart';
import 'customWidget/button/editTextWithIcon.dart';


class LoginForm extends StatelessWidget {

  final UserHttp userHttp = new UserHttp();

  final double _loginOffset ;
  final Function(int) changeState;

  final receiveEmailController = TextEditingController();
  final receivePasswordController = TextEditingController();

  LoginForm(this._loginOffset, this.changeState);

  @override
  Widget build(BuildContext context) {


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

                  EditTextWithIcon("Email", Icons.email, receiveEmailController),
                  EditTextWithIcon("Password", Icons.vpn_key, receivePasswordController),
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: (){
                      var scaffold = Scaffold.of(context);

                      userHttp.getUser(receiveEmailController.text, receivePasswordController.text).then((value) => {
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(value.email),
                            action: SnackBarAction(
                              label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar,
                            ),
                          )
                        )
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

    