
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/pages/InfoVerificationPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatefulWidget {
  NewPassword({Key key, this.title, this.code }) : super(key: key);
  final String title;
  final code ;

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {

  TextEditingController _editpassword = new TextEditingController();
  TextEditingController _editpasswordConfirm = new TextEditingController();
  
  

  bool _isLoading = false;  
  bool _validate = false;
  bool _validateConfirmation = false;

  String _confirmMsg ="This field is required";
  

  
  Api api = new Api();


  _showAlert(String title,String message, String okButton) async {
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
        
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left:15,right:15),
              width: width,
              child:Text("Hi !",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40), textAlign: TextAlign.left,),
            ),
            Container(
              padding: EdgeInsets.only(left:15,right:15),
              width: width,
              child:Text("This is your first time here, please create a password to secure your account." 
              , style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            ),
            
            
            Container(height: 25,),

            Container(
              padding: EdgeInsets.only(left:15,right:15),
              child: TextField(
                controller: _editpassword,
                obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',
                    errorText: _validate ? 'This field is required ( 8 caractères minimum )' : null,
                  ),
                

              ),
            ),
            Container(height: 15,),
            Container(
              padding: EdgeInsets.only(left:15,right:15),
              child:  TextField(
                controller: _editpasswordConfirm,
                obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'confirm password',
                    errorText: _validateConfirmation ? _confirmMsg : null,
                  ),
                

              ),
            ),
            Container(height: 15,),
              ! 
              
              _isLoading ? 

              GestureDetector(child: FluidButton(text: "UPDATE NOW",), onTap: (){
                /*setState(() {
                  _isLoading = true;
                });*/
                String newPassword = _editpassword.text;
                String newPasswordConfirm = _editpasswordConfirm.text;

                if(newPassword.length >= 8 ){
                  if (newPasswordConfirm == "") {
                    setState(() {
                      _validateConfirmation = true;
                      _validate = false;
                    });
                  }else if( newPasswordConfirm != newPassword ){
                      setState(() {
                      _validateConfirmation = true;
                      _validate = false;
                      _confirmMsg= "Passwords do not match";
                    });
                  }else if( newPasswordConfirm == newPassword ){
                    setState(() {
                      _validate = false;
                      _validateConfirmation=false;
                      _confirmMsg ="This field is required";
                      _isLoading = true;
                    });


                    // make api request
                    api.updateUserPassword(widget.code, newPassword).then((response)async{

                      final body = json.decode(response.body);
                      bool success = body['success'];
                      print(body);
                      
                      if (success) {
                        //we save the token first
                        String token = body['token'];
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('token', token); //to activate later
                        // go to phone and email verification page
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => InfoVerificationPage(code: widget.code,)));
                      } else {
                        _showAlert("Erreur", body['message'], "ok");
                      }


                      setState(() {
                        _isLoading = false;
                      });
                    }).catchError((e){
                    _showAlert("Error", "An error has occurred, check your phone's connectivity and try again.", "ok");
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  }
                }else{
                  setState(() {
                    _validate = true;
                    _validateConfirmation=false;
                    _confirmMsg ="This field is required";

                  });
                }               

              },)



              :
            Container(
              padding: EdgeInsets.only(top: 15),
              child: CircularProgressIndicator(),
            ),
            

          ])),),
      

    );
  }
}
