import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String buttonText;

  PrimaryButton(this.buttonText);

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
          color: Color(0XFF0288D1),
          borderRadius: BorderRadius.circular(50)
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
        ),
      ),
    );
  }
}
