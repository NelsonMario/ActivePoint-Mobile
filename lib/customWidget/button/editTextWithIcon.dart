import 'package:flutter/material.dart';

class EditTextWithIcon extends StatelessWidget {

  final String hintString;
  final IconData icon;
  final receiveInputController;


  EditTextWithIcon(this.hintString, this.icon, this.receiveInputController);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 10
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0XFF0288D1),
          width: 2
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            child: Icon(
                icon,
                size: 20,
                color: Colors.grey,
            )
          ),
          Expanded(
            child: TextField(
              controller: receiveInputController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: hintString
              ),
            ),
          )
        ],
      ),
    );
  }
}
