import 'package:activepoint_frontend/dashboard.dart';
import 'package:activepoint_frontend/profilePage.dart';
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
    RewardPage(),
    Dashboard(),
    TaskPage(),
    ProfilePage()
  ];

  int _currentIndex = 1;
  String token;

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    setState(() {
      _readToken().then((value) => token = value);
    });

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.white,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.monetization_on, size: 20, color: Colors.black,),
          Icon(Icons.add, size: 20, color: Colors.black,),
          Icon(Icons.supervised_user_circle, size: 20, color: Colors.black,),
          Icon(Icons.verified_user, size: 20, color: Colors.black,)
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

  return _token ;
}