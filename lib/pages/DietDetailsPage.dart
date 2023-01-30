
import 'dart:convert';
import 'dart:developer';

import 'package:coach_abdou/componenets/BackButtonProject.dart';
import 'package:coach_abdou/componenets/ExercicePreview.dart';
import 'package:coach_abdou/componenets/MealDetails.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietDetailsPage extends StatefulWidget {

   final dynamic diet;
   
  DietDetailsPage({Key key, this.diet, }) : super(key: key);


  @override
  _DietDetailsPageState createState() => _DietDetailsPageState();
}

class _DietDetailsPageState extends State<DietDetailsPage> {
  Api api = new Api();
  String _day;
  dynamic _diet;
  dynamic _info;
  dynamic _meals;
  

  bool _showSetsAndReps = true;
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _diet = widget.diet ;
    print(_diet);

    _info = json.decode(_diet['data_duplication']);

    print(_info['title']);

  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      
        
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(47, 65, 82, 1),
          ),

          
          child: ListView(
          children: [
            BackButtonProject(),
                        Container(
                  width: width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    "DIET PLAN : "+_info['info']['title'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
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

            
Column(children: _info['meals'].map<Widget>((item) {
                              return MealDetails(meal: item,);

                            }).toList(),) ,



                          _info['info']['note'] != null ?  
                          

                          
                          Container(
                            width: width,
                            margin: EdgeInsets.only(left:15,right:15),
                            
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                    'Note',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 219, 20, 1)),
                  ),

                  

                  Container(
                    margin: EdgeInsets.only(top:15,bottom:25),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.white),
                    width: width,
                    child: Text(_info['info']['note'], style: TextStyle(color: Colors.black,fontSize: 20,
                        fontWeight: FontWeight.w300,),),
                  )
                            ],)
                            
                            
                            
                            
                            
                          ):Container()
                
                         

            
            
          ],
        ),
        )
        
        );
  }
}
