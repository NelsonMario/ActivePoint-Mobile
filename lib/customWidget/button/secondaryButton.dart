import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {

  final String buttonText;

  SecondaryButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 0
      ),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0XFF0288D1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              color: Color(0XFF0288D1),
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
