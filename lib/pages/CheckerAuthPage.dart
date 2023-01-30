
import 'dart:convert';

import 'package:coach_abdou/pages/LetsGoPage.dart';
import 'package:coach_abdou/pages/UpdateUserPhotos.dart';
import 'package:coach_abdou/pages/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckerAuthPage extends StatefulWidget {
  CheckerAuthPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CheckerAuthPageState createState() => _CheckerAuthPageState();
}

class _CheckerAuthPageState extends State<CheckerAuthPage> {

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
    // to sign in page
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (BuildContext context) =>  LetsGoPage()));
  } else {
        Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (BuildContext context) => HomePage()   ));
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator()
          ])),
      

    );
  }
}
