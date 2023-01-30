import 'dart:async';
import 'dart:convert';

import 'package:coach_abdou/pages/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LetsGoPage extends StatefulWidget {
  LetsGoPage({Key key}) : super(key: key);

  @override
  _LetsGoPageState createState() => _LetsGoPageState();
}

class _LetsGoPageState extends State<LetsGoPage> {
  bool _isLoading = false;
  Api api = new Api();
  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Additional code

    _showData();
  }

  _displayUI() {
    setState(() {
      _visible = true;
    });
  }

  _showData() async {
    Timer t = new Timer(Duration(seconds: 2), () {
      _displayUI();
    });
  }

  _checkForAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token == null) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  'assets/2.jpg',
                ))),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 700),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                  width: d,
                  child: Text(
                    "ARE YOU READY FOR THE\nCHALLENGE?",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25, color: Colors.grey.shade400),
                  ),
                ),
              ),
              Container(
                height: 25,
              ),
              AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1200),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                    width: d,
                    child: Container(
                      height: 80,
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 0, right: 7.5),
                        width: d,
                        child: FlatButton(
                          child: Text(
                            "LET'S GO!",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        WelcomePage()));
                          },
                          color: Color.fromRGBO(251, 219, 20, 1),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                      ),
                    )),
              ),
              Container(
                height: 25,
              )
            ])),
      ),
    );
  }
}
