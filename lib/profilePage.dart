import 'package:activepoint_frontend/customWidget/button/secondaryButton.dart';
import 'package:activepoint_frontend/service/http/getToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TokenHttp tokenHttp = new TokenHttp();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
}


