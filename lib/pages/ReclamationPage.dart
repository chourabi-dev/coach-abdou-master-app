

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/GymAndPlanInfo.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/componenets/HomeUserCard.dart';
import 'package:coach_abdou/componenets/InovicesCard.dart';
import 'package:coach_abdou/componenets/MyTickets.dart';
import 'package:coach_abdou/pages/NewReclamations.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class ReclamationPage extends StatefulWidget {
  ReclamationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ReclamationPageState createState() => _ReclamationPageState();
}

class _ReclamationPageState extends State<ReclamationPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = null;
  dynamic payments = null;
  dynamic _notifications = [];
  dynamic _reclamations = [];
  
  
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
        _reclamations = body['reclamations'];

        List<dynamic> _tmp = [];

        for (var rec in _reclamations) {
          _tmp.add(rec);
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


  }




  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: ()async{
         /*await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewReclamationPage()),
        );*/

         pushDynamicScreen(
        context,
        screen: MaterialPageRoute(builder: (context) => NewReclamationPage()),
        withNavBar: false,
        
    );


        _getMemberInformations();
        },
      ),
        appBar: AppBar(
          backgroundColor:  Colors.purple,
          title: Text("Complaints"),
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
                    title: Text('${items[index]["title_reclamation"]}' , style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    subtitle: Text('${items[index]["date_reclamation"]} \n${items[index]["core_reclamation"]}'),
                    
                    
                    
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
