
import 'dart:convert';

import 'package:coach_abdou/componenets/TrainingLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/GymAndPlanInfo.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/componenets/HomeUserCard.dart';
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

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = [];
  dynamic payments = [];
  dynamic _notifications = [];
  dynamic _reclamtions = [];
  dynamic _workout;

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
      } else {
        _showError();
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
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade900
          ),
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
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  

                                 

                                     





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
