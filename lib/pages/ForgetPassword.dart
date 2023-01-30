import 'dart:convert';
import 'dart:math';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isLoading = false;
  Api api = new Api();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();

  bool _errEmail = false;
  String _errEmailText = '';
  String _newPasswordError = ''; 
  String _codeError = '';

  String resetCode;

  bool _canRest = false;

  bool _canUpdatePassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Container(
            color: Colors.blueGrey.shade900,
            height: 120,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(),
                Container(
                  height: 15,
                ),
                new Text(
                  "Please wait...",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAlert(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text(
            title,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: TextStyle(color: Colors.grey.shade400)),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _checkForAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token == null) {
    } else {}
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  _checkInputs() {
    String email = _emailController.text.trim();

    if (email == "") {
      setState(() {
        _errEmailText = "This feild is required";
        _errEmail = true;
      });
    } else {
      //_onLoading();
      resetCode = generateRandomString(5);
      print(resetCode);

      setState(() {
        _canRest = true;
      });

      /*api.resetPassword(email).then((response) async {
          Navigator.pop(context);

          if (response != null) {
            final body = json.decode(response.body);
            print(body);

            if (body['success']) {
              print(body);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String token = body['token'];
              await prefs.setString('token', token); //to activate later

              // now go to home page
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
            } else {
              _showAlert('Error', body['message']);
            }
          } else {
            print("good fail");
            _showAlert('Error',
                'Something went wrong while trying to make the request, please try again.');
          }
        }).catchError((err) {
          Navigator.pop(context);
          print("fail");
          _showAlert('Error',
              'Something went wrong while trying to make the request, please try again.');
        });
        */
    }
  }

  _verifyCodefn() {
    String inputCode = _codeController.text;

    if (inputCode != '') {
      setState(() {
        _codeError = '';
      });

      if (inputCode == resetCode) {
        setState(() {
          _codeError = '';
        });
        setState(() {
          _canUpdatePassword = true;
        });
      } else {
        setState(() {
          _codeError = 'Wrong verification code.';
        });
      }
    } else {
      setState(() {
        _codeError = 'This feild is required.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(
                    'assets/1.jpg',
                  ))),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Center(
              child: _canRest == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Text(
                            "FORGET PASSWORD ?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 35, color: Colors.grey.shade400),
                          ),
                          Container(
                            child: Text(
                              "In order to rest your password , please type your email",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade400),
                            ),
                            margin: EdgeInsets.only(bottom: 20),
                          ),
                          Container(
                            height: 8,
                            color: Color.fromRGBO(251, 219, 20, 1),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 18),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              style: TextStyle(
                                  color: Color.fromRGBO(251, 219, 20, 1)),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.grey.shade400)),
                                labelText: 'Email',
                                labelStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                errorText: _errEmail ? _errEmailText : null,
                              ),
                            ),
                          ),
                          Container(
                            width: d,
                            height: 80,
                            child: Container(
                              height: 70,
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 0, right: 0),
                              width: d,
                              child: FlatButton(
                                child: Text(
                                  "Verify !",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade900),
                                ),
                                onPressed: () {
                                  _checkInputs();
                                },
                                color: Color.fromRGBO(251, 219, 20, 1),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                              ),
                            ),
                          ),
                          AboutBloc(
                            screenWidth: d,
                          )
                        ])
                  : _canUpdatePassword == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text(
                                "VERIFICATION CODE !",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 35, color: Colors.grey.shade400),
                              ),
                              Container(
                                child: Text(
                                  "A code has been sent to your address email, type the code in the field down below to rest your password",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade400),
                                ),
                                margin: EdgeInsets.only(bottom: 20),
                              ),
                              Container(
                                height: 8,
                                color: Color.fromRGBO(251, 219, 20, 1),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 18),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: _codeController,
                                  style: TextStyle(
                                      color: Color.fromRGBO(251, 219, 20, 1)),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText: 'Code',
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade400),
                                      errorText:
                                          _codeError != '' ? _codeError : null),
                                ),
                              ),
                              Container(
                                width: d,
                                height: 80,
                                child: Container(
                                  height: 70,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 0, right: 0),
                                  width: d,
                                  child: FlatButton(
                                    child: Text(
                                      "Verify code!",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey.shade900),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _verifyCodefn();
                                      });
                                    },
                                    color: Color.fromRGBO(251, 219, 20, 1),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                              AboutBloc(
                                screenWidth: d,
                              )
                            ])
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Text(
                                "RESET PASSWORD",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 35, color: Colors.grey.shade400),
                              ),
                              Container(
                                height: 8,
                                color: Color.fromRGBO(251, 219, 20, 1),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 18),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: _newPasswordController,
                                  style: TextStyle(
                                      color: Color.fromRGBO(251, 219, 20, 1)),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText: 'New password',
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade400),
                                      errorText: _newPasswordError != ''
                                          ? _newPasswordError
                                          : null),
                                ),
                              ),
                              Container(
                                width: d,
                                height: 80,
                                child: Container(
                                  height: 70,
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 0, right: 0),
                                  width: d,
                                  child: FlatButton(
                                    child: Text(
                                      "Save password",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey.shade900),
                                    ),
                                    onPressed: () {
                                       // to the server and to sign in
                                    },
                                    color: Color.fromRGBO(251, 219, 20, 1),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                  ),
                                ),
                              ),
                              AboutBloc(
                                screenWidth: d,
                              )
                            ])),
        ),
      ),
    );
  }
}
