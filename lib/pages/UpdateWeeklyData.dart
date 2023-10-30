import 'dart:convert';
import 'dart:io';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/componenets/BackButtonProject.dart';
import 'package:coach_abdou/componenets/LabelInput.dart';
import 'package:coach_abdou/pages/NewSignInPage.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/HomeScreen.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:app_review/app_review.dart';


class UpdateWeeklyData extends StatefulWidget {

  UpdateWeeklyData({Key key}) : super(key: key);

  @override
  _UpdateWeeklyDataState createState() => _UpdateWeeklyDataState();
}

class _UpdateWeeklyDataState extends State<UpdateWeeklyData> {
  bool _isLoading = false;
  Api api = new Api();



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



  TextEditingController _waistController = new TextEditingController();


  TextEditingController _weightController = new TextEditingController();


  TextEditingController _feedbackController = new TextEditingController();

  

  


  bool _visible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();

    


    

    //_openStoreListing();
  }


   _requestReview() async {
       
          /*AppReview.storeListing.then((res)=>{
                             
                            }).catchError((err)=>{
                              
                            });*/
      

  }


   Future<void> _askForReview() async {

 SharedPreferences prfs = await SharedPreferences.getInstance();

      if ( prfs.getInt('check-count') != null ) {
          return null;
        

      }else{
        prfs.setInt('check-count',1); 
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text("Review",style: TextStyle(color: Colors.white,fontSize: 30),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Center(
                  child: Row(children: [
                    Icon(Icons.star,color: Colors.amberAccent, size: 35,),
                    Icon(Icons.star,color: Colors.amberAccent, size: 35,),
                    Icon(Icons.star,color: Colors.amberAccent, size: 35,),
                    Icon(Icons.star,color: Colors.amberAccent, size: 35,),
                    Icon(Icons.star,color: Colors.amberAccent, size: 35,),
                    
                  ],),
                ),
              ),
              Text("Do you enjoy using our app ?",style: TextStyle(color: Colors.white,fontSize: 23),),
            ],
          ),
        ),
        actions: <Widget>[


         FlatButton(
            child: Text('NO'),
            onPressed: () {
              Navigator.of(context).pop();
              
            },
          ),
          FlatButton(
            child: Text('YES'),
            onPressed: () {
              Navigator.of(context).pop();
              _requestReview();
            },
          ),
        ],
      );
    },
  );
        
      }



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

  bool _inputControlCheck(){
    String weight = _weightController.text;
    String waist = _waistController.text;

    if( weight!='' && waist != '' ){
      return true;
    }
    
    return false;
  }

  _uploadAllImages(){
    if( _inputControlCheck() ){
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
       _showAlert("Error", "Please update your weight and waist size first.");
    }

  }

  _uploadProfilePicture(){
    _onLoading();

    String weight = _weightController.text;
    String waist = _waistController.text;
    String feedback = _feedbackController.text;
    

      

      api.uploadWeeklyDataAndImages(  _sideAvatarFileimage,_frontAvatarFileimage, _backAvatarFileimage, weight , waist , feedback ).then((response){
        
        final body = json.decode(response.body);
        if( (body['success']) ==true ){
          Navigator.pop(context);
          
          _showAlert("Update", body['message']).then((value) => Navigator.pop(context) ).then((value) => _askForReview()); 
         

        }else{
          Navigator.pop(context);
          _showAlert("Error", body['message']);
        }
      }).catchError((e){
        print(e.toString());
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
            
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                BackButtonProject(),

                Container(
                  width: d,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    "WEEKLY UPDATE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 40,
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
                

                // feils
                
                Row(
                  children: [
                    Container(
                      width: d*0.4,
                      child: Text("Weight (Kg)",textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                    ),
                    Container(
                  width: d*0.6,
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    
                  ),
                ),
              ),
                  ],
                ),



                Container(height: 25,),

                Row(
                  children: [
                    Container(
                      width: d*0.4,
                      child: Text("Waist (cm)",textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
                    ),
                    Container(
                  width: d*0.6,
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _waistController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
                  ],
                ),

                
Container(height: 25,),

                



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


                // feed back block
              LabelInput(screenWidth: d,leftText: "Feedback about last week",righTtext: "",),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  maxLines: 4,

                  controller: _feedbackController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'diet , workout , cardio , sleep , digestion , others...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),






                // end feed back block




                Container(
                  margin: EdgeInsets.only(top:15),
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
                            "UPDATE",
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
