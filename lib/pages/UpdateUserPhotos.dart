import 'dart:convert';
import 'dart:io';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/pages/NewSignInPage.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserPhtotPage extends StatefulWidget {

  UpdateUserPhtotPage({Key key}) : super(key: key);

  @override
  _UpdateUserPhtotPageState createState() => _UpdateUserPhtotPageState();
}

class _UpdateUserPhtotPageState extends State<UpdateUserPhtotPage> {
  bool _isLoading = false;
  Api api = new Api();


  String _mainAvatar = "assets/avatar.png";
  bool _didChooseMainAvatar = false;
  File _mainAvatarFileimage;
  String _mainAvatarTextStatus = "PROFILE";
  /******************** */

  String _sideAvatar = "assets/side.png";
  bool _didChooseSideAvatar = false;
  File _sideAvatarFileimage;
  String _sideAvatarTextStatus = "SIDE";

  /*********************** */


  String _frontAvatar = "assets/front.png";
  bool _didChooseFrontAvatar = false;
  File _frontAvatarFileimage;
  String _frontAvatarTextStatus = "FRONT";


  /*********************** */


  String _backAvatar = "assets/back.png";
  bool _didChooseBackAvatar = false;
  File _backAvatarFileimage;
  String _backAvatarTextStatus = "BACK";
  TextStyle _labelStyle = new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold);

  /********************************* */

  bool _visible = true;
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
              Container(height: 15,),
              new Text("Please wait...",style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
            ],
          ),
          ),
        );
      },
    );
  }

  Future<void> _showAlert(String title,String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(title,style: TextStyle(color: Colors.white),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message,style: TextStyle(color: Colors.white)),
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

  _uploadAllImages(){
    if( _didChooseMainAvatar ){
      if( _didChooseBackAvatar ){
        if( _didChooseSideAvatar ){
          if( _didChooseFrontAvatar ){
              _uploadProfilePicture();
          }else{
            // alert front avatar
             _showAlert("Error", "Please choose a front picture for your body.");
          }
        }else{
          // alert side avatar
          _showAlert("Error", "Please choose a side picture for your body.");
        }
      }else{
        //alert back avatar
         _showAlert("Error", "Please choose a back picture for your body.");
      }
    }else{
      // alert main avatar
       _showAlert("Error", "Please choose a profile picture first.");
    }

  }

  _uploadProfilePicture(){
    _onLoading();

    api.uploadProfilePicture(_mainAvatarFileimage).then((value){
      

      api.uploadWeeklyImages(  _sideAvatarFileimage,_frontAvatarFileimage, _backAvatarFileimage ).then((response){
        
        final body = json.decode(response.body);
        if( (body['success']) ==true ){
          Navigator.pop(context);
          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));

        }else{
          Navigator.pop(context);
          _showAlert("Error", body['message']);
        }
      }).catchError((e){
        print(e.toString());
        Navigator.pop(context);
      _showAlert("Error", "Something went wrong, please try again.");
      });


    }).catchError((e){
      print("1");
      Navigator.pop(context);
      _showAlert("Error", "Something went wrong, please try again.");
    });

  }

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        body: SingleChildScrollView(
          child: Container(
            height: h,
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: d,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    "PHOTOS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 219, 20, 1)),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                  height: 3,
                  color: Colors.white,
                ),
                Container(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if (image != null) {
                        setState(() {
                        _mainAvatarFileimage = image;
                        _didChooseMainAvatar = true;
                        //_mainAvatarTextStatus="Ready !";
                      });
                    }

                    // start uploading to server




                  },
                  child: Container(
                      height: 150,
                      width: 150,
                      child: _didChooseMainAvatar == false
                          ? CircleAvatar(
                              backgroundImage: AssetImage(_mainAvatar),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_mainAvatarFileimage),
                            )),
                ),
                Container(
                  padding: EdgeInsets.only(top:25,bottom:25),
                  child: Text(
                    _mainAvatarTextStatus,
                    style: _labelStyle,
                  ),
                ),



                Container(
                  width: d,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                
                /************************************************************************* */
                Container(
                  width: (d/ 3),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  GestureDetector(
                  onTap: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if( image != null ){
                      setState(() {
                        _backAvatarFileimage = image;
                        _didChooseBackAvatar = true;
                        //_backAvatarTextStatus="Ready !";
                      });
                      
                    }



                  },
                  child: Container(
                      height: (d/3)-30,
                      width: (d/3)-30,
                      child: _didChooseBackAvatar == false
                          ? CircleAvatar(
                              backgroundImage: AssetImage(_backAvatar),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_backAvatarFileimage),
                            )),
                  ),
                  Container(
                     padding: EdgeInsets.only(top:15,bottom:25),
                  child: Text(
                    _backAvatarTextStatus,
                    style: _labelStyle,
                  ),
                ),


                ],),
                ),
                /************************************************************************* */
                Container(
                  width: (d/3),
                  child: Column(children: [
                    GestureDetector(
                  onTap: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if( image != null  ){
                      setState(() {
                        _sideAvatarFileimage = image;
                        _didChooseSideAvatar = true;
                        //_sideAvatarTextStatus="Ready !";
                      });
                      
                    }



                  },
                  child: Container(
                      height: (d/3)-30,
                      width: (d/3)-30,
                      child: _didChooseSideAvatar == false
                          ? CircleAvatar(
                              backgroundImage: AssetImage(_sideAvatar),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_sideAvatarFileimage),
                            )),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:15,bottom:25),
                  child: Text(
                    _sideAvatarTextStatus,
                    style: _labelStyle,
                  ),
                ),

                  ],),
                ),

                /************************************************************************* */
                Container(
                  width: (d/3),
                  child: Column(children: [
                                    GestureDetector(
                  onTap: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if( image != null ){
                        setState(() {
                          _frontAvatarFileimage = image;
                          _didChooseFrontAvatar = true;
                          //_frontAvatarTextStatus="Ready !";
                        });
                        
                    }



                  },
                  child: Container(
                      height: (d/3)-30,
                      width: (d/3)-30,
                      child: _didChooseFrontAvatar == false
                          ? CircleAvatar(
                              backgroundImage: AssetImage(_frontAvatar),
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(_frontAvatarFileimage),
                            )),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:15,bottom:25),
                  child: Text(
                    _frontAvatarTextStatus,
                    style: _labelStyle,
                  ),
                ),
                  ],),
                ),
                /*************************************************************************** */







                ],),),

                Container(
                  padding: EdgeInsets.only(left:15,right:15),
                  child: AnimatedOpacity(
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
                            "CREATE NOW",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900),
                          ),
                          onPressed: () {
                            _uploadAllImages();
                          },
                          color: Color.fromRGBO(251, 219, 20, 1),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                        ),
                      ),
                    )),
              ),
                )







              ],
            ),
          ),
        ));
  }
}
