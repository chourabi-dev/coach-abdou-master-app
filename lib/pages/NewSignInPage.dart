import 'dart:convert';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/pages/ForgetPassword.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailPasswordSigninPage extends StatefulWidget {
  EmailPasswordSigninPage({Key key}) : super(key: key);

  @override
  _EmailPasswordSigninPageState createState() =>
      _EmailPasswordSigninPageState();
}

class _EmailPasswordSigninPageState extends State<EmailPasswordSigninPage> {
  bool _isLoading = false;
  Api api = new Api();

  TextEditingController _emailController = new TextEditingController();
  bool _errEmail = false;
  String _errEmailText = '';

  TextEditingController _passwordController = new TextEditingController();
  bool _errPassword = false;
  String _errPasswordText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();
  }





  _openResetPassword() async {
    const url = 'https://coach-abdou.com/API/mobile/public/index.php';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

  _checkInputs() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email == "") {
      setState(() {
        _errEmailText = "This feild is required";
        _errEmail = true;
      });
    } else {
      setState(() {
        _errEmailText = "";
        _errEmail = false;
      });

      if (password == "") {
        setState(() {
          _errPasswordText = "This feild is required";
          _errPassword = true;
        });
      } else {
        setState(() {
          _errPasswordText = "";
          _errPassword = false;
        });

        /** safe to send API requesr */

        _onLoading();
        api.signInUser(email, password).then((response) async {
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
      }
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(
                  "SIGN IN",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 35, color: Colors.grey.shade400),
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
                    style: TextStyle(color: Color.fromRGBO(251, 219, 20, 1)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: new OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.grey.shade400)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey.shade400),
                      errorText: _errEmail ? _errEmailText : null,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18,bottom: 18),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Color.fromRGBO(251, 219, 20, 1)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: new OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: Colors.grey.shade400)),
                      labelText: 'Password ',
                      labelStyle: TextStyle(color: Colors.grey.shade400),
                      errorText: _errPassword ? _errPasswordText : null,
                    ),
                  ),
                ),


                GestureDetector(
                  onTap: (){
                    /*Navigator.push(context, new MaterialPageRoute(builder: (context){
                      return new ResetPasswordPage();
                    }));*/

                    _openResetPassword();
                  },
              child: Container(
              padding: EdgeInsets.only( ),
              child: Text(
                'Forget password ?',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
              ),
            ),
            ),



                Container(
                  width: d,
                  height: 80,
                  child: Container(
                    height: 70,
                    padding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                    width: d,
                    child: FlatButton(
                      child: Text(
                        "CONNECT NOW !",
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
                          borderRadius: new BorderRadius.circular(30.0)),
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
