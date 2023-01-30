import 'dart:convert';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/pages/NewSignInPage.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:coach_abdou/pages/TermsAndConditions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isLoading = false;
  Api api = new Api();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();
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
                  'assets/1.jpg',
                ))),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                height: 8,
                color: Color.fromRGBO(251, 219, 20, 1),
              ),
              Container(
                height: 25,
              ),
              Text(
                "“IT’S GOING TO BE A JOURNEY.\n IT’S NOT A SPRINT TO GET IN SHAPE”",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, color: Colors.grey.shade400),
              ),
              Container(
                height: 25,
              ),
              Container(
                height: 8,
                color: Color.fromRGBO(251, 219, 20, 1),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 0, right: 7.5),
                      width: (d - 30) / 2,
                      child: FlatButton(
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade900),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EmailPasswordSigninPage()));
                        },
                        color: Color.fromRGBO(251, 219, 20, 1),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 7.5, right: 0),
                      width: (d - 30) / 2,
                      child: FlatButton(
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade900),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TermsAndConditionsPage()));
                        },
                        color: Color.fromRGBO(251, 219, 20, 1),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                ),
              ),
              AboutBloc(
                screenWidth: d,
              )
            ])),
      ),
    );
  }
}
