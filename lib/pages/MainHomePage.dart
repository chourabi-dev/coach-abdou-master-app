import 'dart:convert';

import 'package:coach_abdou/componenets/TrainingLoader.dart';
import 'package:coach_abdou/pages/CheckerAuthPage.dart';
import 'package:coach_abdou/pages/DietDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/GymAndPlanInfo.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/componenets/HomeUserCard.dart';
import 'package:coach_abdou/componenets/SocialMedias.dart';

import 'package:coach_abdou/componenets/InovicesCard.dart';
import 'package:coach_abdou/componenets/MyNotificationsBloc.dart';
import 'package:coach_abdou/componenets/MyTickets.dart';
import 'package:coach_abdou/pages/AboutPage.dart';
import 'package:coach_abdou/pages/NotificationsPage.dart';
import 'package:coach_abdou/pages/PaymentsHistoryPage.dart';
import 'package:coach_abdou/pages/ReclamationPage.dart';
import 'package:coach_abdou/pages/ReportBug.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/pages/WorkoutPageDetails.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomePage extends StatefulWidget {
  MainHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = [];
  dynamic payments = [];
  dynamic _notifications = [];
  dynamic _reclamtions = [];
  dynamic _workout;
  dynamic _diet;

  bool _errorLoading = false;

  _showError() {
    setState(() {
      _errorLoading = true;
    });
  }

  _hideError() {
    setState(() {
      _errorLoading = false;
    });
  }

  _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  prefs.remove('token');

    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CheckerAuthPage()));
  }

  _getMemberInformations() {
    setState(() {
      _isLoading = true;
      _errorLoading = false;
    });
    api.getUserData().then((response) {
      print(response.body);
      final body = json.decode(response.body);

      if (body['success']) {
        user = body['data'];
        payments = body['payments'];
        _notifications = body['notifications'];
        _reclamtions = body['reclamations'];
        _workout = body['workout'];
        _diet = body['dietPlan'];
      } else {

        _logout();

      }

      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _errorLoading = true;
        _isLoading = false;
      });
    });
  }

  Future<void> _refresherFunction() async {
    await api.getUserData().then((response) {
      final body = json.decode(response.body);
      if (body['success']) {
        setState(() {
          user = body['data'];
          payments = body['payments'];
          _notifications = body['notifications'];
          _reclamtions = body['reclamations'];
          _workout = body['workout'];
          _diet = body['dietPlan'];
        });
      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.blueGrey.shade900),
      child: RefreshIndicator(
        onRefresh: _refresherFunction,
        child: ListView(
          children: [
            // container profile

            !_isLoading
                ?

                // check for loading error
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: !_errorLoading
                        ? 

                          this.user['suspend_day'] != null ? Container(
                              height: MediaQuery.of(context).size.height-100,
                                child: Center(
                                  child: Text('Your account was suspended by your personal coach.',textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
                                ),
                              ):
                        
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                             


                              SocialMedias(),
                              HomeUserCard(
                                user: user,
                              ),

                              _diet != null ?Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            DietDetailsPage( diet: _diet,  )));
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      height: 150,
                                      width: (screenWidth - 30),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  AssetImage("assets/food.jpg"),
                                              fit: BoxFit.cover)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "DIET",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )):Container(),

                              Container(
                                height: 15,
                              ),

                              _workout != null
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      WorkoutDetailsPage(
                                                          workout: json.decode(
                                                              _workout[
                                                                  'json_workout']))));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          height: 150,
                                          width: (screenWidth - 30),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/gym.jpg"),
                                                  fit: BoxFit.cover)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 15, bottom: 15),
                                                child: Text(
                                                  "TRAINING",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 60,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                  : Container(),

                              // food section

                              ( (_workout != null) || (_diet != null) )
                                  ? TrainingLoader(
                                      /*workout: _workout,*/
                                    )
                                  : Container()

                              ,
                              _workout == null && _diet == null ?
                              Container(
                                margin: EdgeInsets.only(top:50),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text("HI !",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
                                  Text('Wait for coach abdou to assign you a diet and a training.\nstay tuned',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)
                                ],),
                              ):Container()



                            ],
                          )
                        : ErrorLoadingBloc(
                            refresh: () {
                              this._getMemberInformations();
                            },
                          ),
                  )

                : HomeLoader(message: "Loading..."),
          ],
        ),
      ),
    ));
  }
}
