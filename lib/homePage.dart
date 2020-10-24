import 'package:activepoint_frontend/rewardPage.dart';
import 'package:activepoint_frontend/taskPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<HomePage>{

  final List<Widget> _children = [
    TaskPage(),
    TaskPage(),
    RewardPage(),
  ];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {



    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.white,
        backgroundColor: Color(0XFF0288D1),
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.verified_user, size: 20, color: Colors.black,),
          Icon(Icons.add, size: 20, color: Colors.black,),
          Icon(Icons.list, size: 20, color: Colors.black,),
        ],
        animationDuration: Duration(
          milliseconds: 200
        ),
        index: 1,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        onTap: (index){
          onTabTapped(index);
        }
      ),
    );
  }


}





Future<String> _readToken() async {

  String _token = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _token = prefs.getString("REQUEST_TOKEN");

  return _token;
}