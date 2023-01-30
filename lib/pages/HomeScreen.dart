import 'dart:convert';

import 'package:coach_abdou/pages/ComparatorPage.dart';
import 'package:coach_abdou/pages/SettingPage.dart';
import 'package:coach_abdou/pages/StatisticPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:coach_abdou/pages/MainHomePage.dart';
import 'package:coach_abdou/pages/NotificationsPage.dart';
import 'package:coach_abdou/pages/PaymentsHistoryPage.dart';
import 'package:coach_abdou/pages/ReclamationPage.dart';

import 'package:coach_abdou/services/api.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _isLoading = false;
  Api api = new Api();

  dynamic user = [];
  dynamic payments = [];
  dynamic _notifications = [];
  int _notificationsCount = 0;

  dynamic _reclamtions = [];

  bool _errorLoading = false;
  int _selectedIndex = 0;

  PersistentTabController _controllerTabs =
      new PersistentTabController(initialIndex: 0);

  static List<Widget> _widgetOptions = <Widget>[
    MainHomePage(),
    ComparatorPage(),
    StatisticPage(),
    //SettingPage(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
    });

    if(index == 0){
    setState(() {
      _notificationsCount = 0;
      
    });
    }
  }

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

int _nonSeennotifications = 0;

        for (var not in body['notifications']) {
          if (not['is_seen_notification'] == 0) {
            _nonSeennotifications += 1;
          }
        }

      if (body['success']) {
        user = body['data'];
        payments = body['payments'];
        _notifications = body['notifications'];
        _reclamtions = body['reclamations'];
        _notificationsCount = _nonSeennotifications;
      } else {
        _showError();
      }

      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
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
        int _nonSeennotifications = 0;

        for (var not in body['notifications']) {
          if (not['is_seen_notification'] == 0) {
            _nonSeennotifications += 1;
          }
        }

        setState(() {
          user = body['data'];
          payments = body['payments'];
          _notifications = body['notifications'];
          _reclamtions = body['reclamations'];
          _notificationsCount = _notificationsCount;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();
    _notificationsCount = _notificationsCount;
    firebaseCloudMessagingListeners();
    getFirebaseToken();
  }

  getFirebaseToken(){
    try {
          _firebaseMessaging.getToken().then((token) {
            print("token is $token"); // Print the Token in Console
            api.saveMemberToken(token);
          });
          
    } catch (e) {
      print("Error getting token");
    }
  }

  makeVibrationNotification() async{
    if (await Vibration.hasAmplitudeControl()) {
    Vibration.vibrate(amplitude: 128,duration: 1000 );
}
  }

  void firebaseCloudMessagingListeners() {

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      makeVibrationNotification();

      print('on message $message');
            _getMemberInformations();
    },
    onResume: (Map<String, dynamic> message) async {
      makeVibrationNotification();
      
      print('on resume $message');
             _getMemberInformations();
    },
    onLaunch: (Map<String, dynamic> message) async {
      makeVibrationNotification();
      
      print('on launch $message');
        _getMemberInformations();
    },
  );
}



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
      key: _scaffoldKey,

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            title: Text('Compare'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            title: Text('Statistic'),
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),*/
        ],
        currentIndex: _selectedIndex,
        
        onTap: _onItemTapped,
      ),
    );
  }
}
