import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/services/api.dart';

class InfoVerificationPage extends StatefulWidget {
  InfoVerificationPage({Key key, this.title, this.code}) : super(key: key);
  final String title;
  final code;

  @override
  _InfoVerificationPageState createState() => _InfoVerificationPageState();
}

class _InfoVerificationPageState extends State<InfoVerificationPage> {
  TextEditingController _editEmail = new TextEditingController();
  bool _validateEmail = false;

  TextEditingController _editPhone = new TextEditingController();
  bool _validatePhone = false;

  bool _isLoading = false;
  bool _isLoadingData = false;

  Api api = new Api();

  bool _errorChargingData = false;

  _startLoadingData() {
    setState(() {
      _isLoadingData = true;
    });
  }

  _doneLoadingData() {
    setState(() {
      _isLoadingData = false;
    });
  }

  _getUserInformation() {
    print("getting user information" + widget.code);
    _startLoadingData();

    api.getUserInfo(widget.code).then((response) {
      final body = json.decode(response.body);
      bool success = body['success'];

      final user = body['data'];

      if (success) {
        _editPhone.text = user['phone_member'];
        _editEmail.text = user['email_member'];

        setState(() {
          _errorChargingData = false;
        });
      } else {
        setState(() {
          _errorChargingData = true;
        });
      }

      _doneLoadingData();
    }).catchError((e) {
      setState(() {
        _errorChargingData = true;
      });
      _doneLoadingData();
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
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: !_errorChargingData
            ? Container(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      width: width,
                      child: Text(
                        "Wait !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Text(
                        "Please confirm your personal information, and correct it if necessary.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w200),
                      ),
                    ),
                    Container(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _editEmail,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'email',
                          errorText:
                              _validateEmail ? 'This field is required' : null,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _editPhone,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone number',
                          errorText:
                              _validatePhone ? 'This field is required' : null,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    !_isLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            child: !_isLoadingData
                                ? GestureDetector(
                                    child: FluidButton(
                                      text: "I CONFIRM",
                                    ),
                                    onTap: () {
                                      String email = _editEmail.text.trim();
                                      String phone = _editPhone.text.trim();

                                      bool emailValid = RegExp(
                                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                          .hasMatch(email);

                                      if (emailValid == true) {
                                        setState(() {
                                          _validateEmail = false;
                                        });

                                        if (phone.length == 8) {
                                          setState(() {
                                            _validatePhone = false;
                                          });

                                          // make API request

                                          api
                                              .updateUserData(widget.code,
                                                  email.trim(), phone.trim())
                                              .then((response) {
                                            final body =
                                                json.decode(response.body);
                                            bool success = body['success'];

                                            if (success) {
                                              // go to home page
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomePage()));
                                            } else {
                                              _showAlert("Erreur",
                                                  body['message'], "OK");
                                            }
                                          }).catchError((e) {
                                            
                                            _showAlert(
                                                "Error",
                                                "An error has occurred, check your phone's connectivity and try again.",
                                                "OK");
                                          });
                                        } else {
                                          setState(() {
                                            _validatePhone = true;
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          _validateEmail = true;
                                        });
                                      }
                                    },
                                  )
                                : Container(
                                    child: Text("Chargement de vos données..."),
                                  ),
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 15),
                            child: CircularProgressIndicator(),
                          ),
                  ])))
            : Container(
                padding: EdgeInsets.all(15),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Container(
                        width: width,
                        child: Text(
                          "Oups !",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        "An error has occurred, check your phone's connectivity and try again.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w200),
                      ),
                      Container(
                        height: 15,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: FlatButton(
                              child: Text('Try again',
                                  style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                _getUserInformation();
                              }))
                    ]))));
  }
}
