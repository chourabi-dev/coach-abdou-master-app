
import 'dart:convert';

import 'package:coach_abdou/componenets/BackButtonProject.dart';
import 'package:coach_abdou/componenets/ExercicePreview.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/pages/WorkoutExercicesDetails.dart';

class ExercicesDetailsPage extends StatefulWidget {
   final String day;
   final dynamic exercices;
   
  ExercicesDetailsPage({Key key, this.day, this.exercices,}) : super(key: key);


  @override
  _ExercicesDetailsPageState createState() => _ExercicesDetailsPageState();
}

class _ExercicesDetailsPageState extends State<ExercicesDetailsPage> {
  bool _isLoading = false;
  Api api = new Api();
  dynamic _workout;
  String _day;
  dynamic _exercices;
  String _split;
  bool _showSetsAndReps = true;
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _day=widget.day;
    _exercices = widget.exercices['exercices'];
    _split = widget.exercices['split'];

    if (_split.toLowerCase() == "cardio") {
      _showSetsAndReps = false;
    }

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
            Row(children: [
              Container(
                  width: width*0.3,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    _day,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),

                Container(
                  width: width*0.7,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    _split,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 219, 20, 1)),
                  ),
                ),


            ],),
            
                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                  height: 3,
                  color: Colors.white,
                ),

                  Column(children: _exercices.map<Widget>((item) {
                              return ExercicePreview( exercie: item['exercice'],showSets:_showSetsAndReps,isSuperSet: (item['superSet'] != null) ? item['superSet'] : false,);

                            }).toList(),)
                         

            
            
          ],
        ),
        )
        
        );
  }
}
