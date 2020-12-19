import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './customWidget/button/primaryButton.dart';
import './loginForm.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Nunito"
      ),
      home: Scaffold(
        body: Container(
          child: InitPage(),
        ),
      ),
    );
  }
}

class InitPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _InitPageState();
  }
}

class _InitPageState extends State<InitPage>{

  var _pageState = 0;

  Color _backgroundColor = Colors.white;
  Color _headingColor = Color(0XFFF9A826);
  String _imageURL = 'assets/images/undraw_studying_s3l7.png';
  double _headingTop = 100;

  double _windowHeight = 0;
  double _loginOffsetY = 0;


  changeState(pageState){
    setState(() {
      _pageState = pageState;
    });
  }



  @override
  Widget build(BuildContext context) {

    _windowHeight = MediaQuery.of(context).size.height;
    _loginOffsetY = _windowHeight;


    switch(_pageState){
      case 0:
        _backgroundColor = Colors.white;
        _headingColor = Color(0XFF0288D1);
        _loginOffsetY = _windowHeight;
        _headingTop = 100;
        break;

      case 1:
        _backgroundColor = Color(0XFF003257);
        _headingColor = Colors.white;
        _loginOffsetY = _windowHeight * 0.35;
        _headingTop = 90;
        break;
    }
    return Stack(
        children: [
          AnimatedContainer(
            color: _backgroundColor,
            duration: Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  top: _headingTop,
                                  bottom: 20
                              ),
                              child: Text(
                                'Active Point',
                                style: TextStyle(
                                  color: _headingColor,
                                  fontSize: 28,
                                ),
                              )
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 75
                            ),
                            child:   Text(
                              'Enhance your performance. Get a task then redeem the reward.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _headingColor,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Image.asset(_imageURL),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _pageState = 1;
                      });
                    },
                    child: PrimaryButton('Getting Started'),
                  ),
                ),
              ],
            ),
          ),
          LoginForm(_loginOffsetY, changeState)
        ],
    );
  }
}

