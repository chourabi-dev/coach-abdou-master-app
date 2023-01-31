import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/NewPassword.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class SignInPage extends StatefulWidget {
  SignInPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;
  bool _hasPassword = false;
  TextEditingController _editingController = new TextEditingController();
  TextEditingController _editingControllerpassword =
      new TextEditingController();
  bool _validate = false;
  bool _validatePassword = false;

  Api api = new Api();

  _doneLoading() {
    setState(() {
      _isLoading = false;
    });
  }




  _showAlert(String title, String message, String okButton) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(okButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
              image: AssetImage(
        'assets/loginbackground.png',
      ))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Container(
              child: Image(image: AssetImage('assets/logo.png')),
              padding: EdgeInsets.only(left: 60, right: 60, bottom: 20),
            ),*/
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: width,
              child: Text(
                "Welcome !",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "This is Coach Abdou's mobile app, please fill in the connection code provided by your coach.",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextField(
                controller: _editingController,
                obscureText: false,
                
                decoration: InputDecoration(
                  fillColor: Colors.orange,
                  border: OutlineInputBorder(),
                  labelText: 'Login code',
                  errorText: _validate ? 'This field is required' : null,
                ),
              ),
            ),
            _hasPassword
                ? Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: TextField(
                      controller: _editingControllerpassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password ',
                        errorText:
                            _validatePassword ? 'This field is required' : null,
                      ),
                    ),
                  )
                : Container(),
            !_isLoading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: !_hasPassword
                        ? GestureDetector(
                            child: FluidButton(
                              text: "SIGN IN",
                            ),
                            onTap: () {
                              String code;
                              code = _editingController.text;
                              if (code == "") {
                                setState(() {
                                  _validate = true;
                                });
                              } else {
                                setState(() {
                                  _validate = false;
                                });

                                setState(() {
                                  _isLoading = true;
                                });

                                // make API request
                                api.getUserInfo(code).then((response) {
                                  final body = json.decode(response.body);
                                  print(body);
                                  bool success = body['success'];
                                  bool hasPassword = body['hasPassword'];
                                  String message = body['message'];

                                  if (success == true) {
                                    // disable the first input

                                    if (hasPassword) {
                                      // request password feild
                                      setState(() {
                                        _hasPassword = true;
                                      });
                                    } else {
                                      // navigate to new password page
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  NewPassword(
                                                    code: code,
                                                  )));

                                      setState(() {
                                        _hasPassword = false;
                                      });
                                    }
                                  } else {
                                    _showAlert("Error", message, "ok");
                                    setState(() {
                                      _hasPassword = false;
                                    });
                                  }

                                  _doneLoading();
                                }).catchError((e) {
                                  print(e);
                                  _doneLoading();
                                  _showAlert(
                                      "Error",
                                      "An error has occurred, check your phone's connectivity and try again.",
                                      "ok");
                                  
                                });
                              }
                            },
                          )
                        : // flat button of connexion and obtain connexion token
                        !_isLoading
                            ? GestureDetector(
                                child: FluidButton(text: 'SIGN IN'),
                                onTap: () async {
                                  String password =
                                      _editingControllerpassword.text;
                                  String code;
                                  code = _editingController.text;
                                  if (password == "") {
                                    setState(() {
                                      _validatePassword = true;
                                    });
                                  } else {
                                    setState(() {
                                      _validatePassword = false;
                                    });
                                    /******************* make api request for auth ******************* */

                                    setState(() {
                                      _isLoading = true;
                                    });

                                    api
                                        .userAuth(code, password)
                                        .then((response) async {
                                      final body = json.decode(response.body);
                                      bool success = body['success'];

                                      if (success) {
                                        // we save the token in the shared perefs and navigate to home screen
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        String token = body['token'];
                                        await prefs.setString(
                                            'token', token); //to activate later

                                        // now go to home page
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HomePage()));
                                      } else {
                                        String message = body['message'];
                                        _showAlert("Erreur", message, "ok");
                                      }

                                      print(body);

                                      _doneLoading();
                                    }).catchError((e) {
                                      _doneLoading();
                                      _showAlert(
                                          "Error",
                                          "An error has occurred, check your phone's connectivity and try again.",
                                          "ok");
                                          print(e);
                                    });
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 15),
                                child: CircularProgressIndicator(),
                              ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 15),
                    child: CircularProgressIndicator(),
                  ),

                
                   
            GestureDetector(
              child: Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 50),
              child: Text(
                'Developer | Chourabi taher',
                style: TextStyle(fontSize: 18, color: Colors.blue.shade400),
              ),
            ),
            )
          ],
        ),
      ),
    ));
  }
}
