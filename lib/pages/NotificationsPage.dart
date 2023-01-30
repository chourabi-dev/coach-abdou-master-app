


import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/services/api.dart';


class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = null;
  dynamic payments = null;
  dynamic _notifications = [];
  
  bool _errorLoading = false;

  List<dynamic> items = [];



  _showError(){
    setState(() {
      _errorLoading = true;
    });
  }

    _hideError(){
    setState(() {
      _errorLoading = false;
    });
  }

  _getMemberInformations(){
    setState(() {
      _isLoading = true;
      _errorLoading = false;
    });
    api.getUserData().then((response){
      print(response.body);
      final body = json.decode(response.body);

      if (body['success']) {
        user = body['data'];
        payments = body['payments'];
        _notifications = body['notifications'];

        List<dynamic> _tmp = [];

        for (var notification in _notifications) {
          _tmp.add(notification);
        }
        setState(() {
          items = _tmp;
        });

        print(payments);

      }else{
          _showError();
      }
      
          setState(() {
            _isLoading = false;
          });

    }).catchError((e){
      setState(() {
        _errorLoading = true;
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();

    api.updateNotificationsView().then((value) => print("ninja "+value.body));
  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.purple,
          title: Text("Notifications"),
        ),
        body: 
        ! _isLoading ?
        
        ! _errorLoading ?
        ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left:15 , right:15,top: 15),
                    padding: EdgeInsets.only(top:10, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.all(Radius.circular(7)) ,
                      boxShadow: [
                        
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      isThreeLine: false,
                    title: Text('${items[index]["title_notification"]}' , style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    subtitle: Text('${items[index]["date_notification"]} \n${items[index]["core_notification"]}'),
                    
                    trailing: items[index]['is_seen_notification'] == 0 ?
                    Container(
                      margin: EdgeInsets.only(top:20),
                      height: 15,
                      width: 15,
                      
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all( Radius.circular(120)),),
                    ) : null
                    
                  ),
                  );
                },
              )
              :

              ErrorLoadingBloc(refresh: (){
              this._getMemberInformations();
            },)
              
              
              :

              HomeLoader(message:"chargement..."),

        
    

        );
  }
}
