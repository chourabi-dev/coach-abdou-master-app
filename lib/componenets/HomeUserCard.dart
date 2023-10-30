import 'dart:convert';
import 'dart:io';

import 'package:coach_abdou/pages/CheckerAuthPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeUserCard extends StatefulWidget {
  HomeUserCard({Key key, this.title, this.user, this.c}) : super(key: key);
  final String title;
  final user;
  final BuildContext c;

  @override
  _HomeUserCardState createState() => _HomeUserCardState();
}

class _HomeUserCardState extends State<HomeUserCard> {
  bool _isLoading = false;
  Api api = new Api();
  double _presgress = 1;
  dynamic user;

  int plan_duration = 0;
  String name_plan;
  int amount;
  int duration_days;
  String last_renewal_date;
  int reduction;
  int reste;

  int passedDays = 0;
  String _nextRenewlDate = "";


  ImageProvider _profilePicture; 
  File _profilePictureFileimage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    plan_duration = user['duration_days'];
    name_plan = user['name_plan'];
    amount = user['amount'];
    duration_days = user['duration_days'];
    last_renewal_date = user['last_renewal_date'];
    reduction = user['reduction'];
    reste = user['reste'];
    passedDays = countDays();
    _presgress = _countPercentageLevel();
    _nextRenewlDate = _countNextRnewelDay();

    _profilePicture = NetworkImage(user['avatar_member']); 
  }

  getPrefColor(int passedDays, int totalToday) {
    double fraction = passedDays / totalToday;

    if (fraction > 0 && fraction < 0.7) {
      return Colors.white;
    } else if (fraction >= 0.7 && fraction < 0.75) {
      return Colors.yellowAccent.shade700;
    } else if (fraction >= 0.75 && fraction < 0.8) {
      return Colors.deepOrange;
    } else if (fraction >= 0.8 && fraction < 1) {
      return Colors.redAccent;
    } else if (fraction >= 1) {
      return Colors.redAccent;
    }
  }

  _countPercentageLevel() {
    double x = passedDays / duration_days;
    return x;
  }

  countDays() {
    print(last_renewal_date);

    int year = int.parse(last_renewal_date.substring(0, 4));
    int month = int.parse(last_renewal_date.substring(5, 7));
    int days = int.parse(last_renewal_date.substring(8, 10));

    DateTime today = new DateTime.now();

    int diffeeceInMillseconds = today.millisecondsSinceEpoch -
        new DateTime(year, month, days).millisecondsSinceEpoch;
    // transform them into days now

    double daysPassed = (diffeeceInMillseconds / (1000 * 60 * 60 * 24));
    int exactPassedDays = daysPassed.round();

    return exactPassedDays;
    
  }

  _countNextRnewelDay() {
    int year = int.parse(last_renewal_date.substring(0, 4));
    int month = int.parse(last_renewal_date.substring(5, 7));
    int days = int.parse(last_renewal_date.substring(8, 10));

    int nextRenewMills = (plan_duration * 24 * 60 * 60 * 1000) +
        new DateTime(year, month, days).millisecondsSinceEpoch;

    DateTime nextDate = new DateTime.fromMillisecondsSinceEpoch(nextRenewMills);

    return (nextDate.toString().substring(0, 10));
  }

  _getLeftWeeks() {
    int total = ((passedDays) / 7).floor();

    return total;
  }

  _getTotalWeeks() {
    return ((plan_duration) / 7).round();
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


    _uploadProfilePicture(){
    _onLoading();
 

      api.uploadProfilePicture(  _profilePictureFileimage ).then((response){
        
        final body = json.decode(response.body);
        print(body);

        if( (body['success']) ==true ){
          //Navigator.pop(context);
          
          _showAlert("Update", 'Profile picture updated successfully !').then((value) => Navigator.pop(context));

            setState(() {
              _profilePicture = FileImage(_profilePictureFileimage);
            });

        }else{
          Navigator.pop(context);
          _showAlert("Error", 'Something went wrong, please try again.').then((value) => Navigator.pop(context));
        }
      }).catchError((e){
        print(e.toString());
        Navigator.pop(context);
      _showAlert("Error", "Something went wrong, please try again.");
      });
 
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            width: (MediaQuery.of(context).size.width - 30) * 0.25,
            child: 
                
                GestureDetector(
                  onTap: () async {
                    File image = await ImagePicker.pickImage(
                        source: ImageSource.gallery, imageQuality: 50);

                    if( image != null ){ 
                      setState(() {
                        _profilePictureFileimage = image; 
                        _uploadProfilePicture();

                      });
                      
                    }



                  },
                  child: Container(
                      
                      child: Stack(children: [
                        CircleAvatar( 
                          radius: ((MediaQuery.of(context).size.width - 30) * 0.25) / 2,
                          backgroundColor: Colors.grey.shade600,
                          backgroundImage: _profilePicture
                          ),
                          Positioned(
                            
                            child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                            width: 35,
                            height: 35,
                            
                            child: Center(
                                child: Icon(Icons.camera_alt,color: Colors.amberAccent ,),
                              ),
                            ),
                            bottom: 0,
                            right: 0,
                          )

                        
                      ],)
                
                ),
                  )
                
                
                
                ,
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 30) * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 0,
                ),
                Text(
                  user['fullname_member'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                /*Text(user['email_member'],
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15)),*/
                Container(
                  height: 15,
                ),
                ((plan_duration - passedDays) > 0)
                    ?
                    //($passedDays / $plan_duration)
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: ((MediaQuery.of(context).size.width - 30) *
                                      0.75) /
                                  2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("N° CURRENT WEEK",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromRGBO(251, 219, 20, 1),
                                      )),
                                  Text("${_getLeftWeeks()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: getPrefColor(
                                              passedDays, plan_duration))),
                                ],
                              )),
                          Container(
                              width: ((MediaQuery.of(context).size.width - 30) *
                                      0.75) /
                                  2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("N° WEEKS LEFT",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromRGBO(251, 219, 20, 1),
                                      )),
                                  Text("${_getTotalWeeks()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: getPrefColor(
                                              passedDays, plan_duration))),
                                ],
                              ))
                        ],
                      )
                    : Text(
                        "Your subscription has been exhausted, please contact Coach Abdou",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.redAccent)),
                Container(
                  child: FlatButton(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log Out',
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 24),
                        ),
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.yellowAccent,
                          size: 24,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String token = prefs.getString('token');

                      prefs.remove('token');

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CheckerAuthPage()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
