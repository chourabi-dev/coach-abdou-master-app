import 'dart:convert';

import 'package:coach_abdou/componenets/BackButtonProject.dart';
import 'package:coach_abdou/pages/ExercicesDetailsPage.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/pages/WorkoutExercicesDetails.dart';

class WorkoutDetailsPage extends StatefulWidget {
  WorkoutDetailsPage({Key key, this.title, this.workout, this.weekNumber = 0}) : super(key: key);
  final String title;
  final dynamic workout;
  final int weekNumber; 

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  bool _isLoading = false;
  Api api = new Api();
  dynamic _workout;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _workout = widget.workout;

    print(widget.workout);
  }

  generateDayIcon(String split){
    if( split.toLowerCase() == "cardio" ){
      return Image.asset("assets/cardio.PNG",width: 46,);
    }else{
      return Image.asset("assets/training-day.PNG",width: 46,);
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
            Container(
                  width: width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    "WORKOUT PLAN",
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


            /*Container(
              padding: EdgeInsets.only(top:90),
              height: 200,
              child: Text(_workout['title'],style: TextStyle( color: Color.fromRGBO(251, 219, 20, 1), fontWeight: FontWeight.bold,fontSize: 35),textAlign: TextAlign.center,),
            ),*/
            
            Container(
                  
                  
                  padding: EdgeInsets.only(left: 15, right: 15),
                   
                    child: Column(
                      children: [
                        Container(
                          
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                             
                              Container(
                                width: (width -30) / 3,
                                child: Column(
                                  children: [
                                    Image.asset('assets/goal.PNG',width: 30,),
                                    Text("${_workout["goal"]}",style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                              Container(
                                width: (width -30) / 3,
                                child: Column(
                                  children: [
                                    Image.asset('assets/training.PNG',width: 30,),
                                    Text("${_workout["bodysection"]}",style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                               Container(
                                width: (width - 30) / 3,
                                child: Column(
                                  children: [
                                    Image.asset('assets/duration.PNG',width: 30,),
                                    
                                    Text("${_workout["duration"]} week(s)",style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 30,),

                        ListTile(
                          title: Text("Monday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                          subtitle: this._workout['program']['monday'] != null? Text("${this._workout['program']['monday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['monday'] != null?  generateDayIcon(this._workout['program']['monday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                           trailing: this._workout['program']['monday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['monday'] != null ){
                                Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Monday',exercices: this._workout['program']['monday'] )  ));
                                  
                             }
                           },  
                        ),

                        
                        ListTile(
                          title: Text("Tusday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                          subtitle: this._workout['program']['tusday'] != null? Text("${this._workout['program']['tusday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['tusday'] != null?  generateDayIcon(this._workout['program']['tusday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                           trailing: this._workout['program']['tusday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['tusday'] != null ){
                               Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Tusday',exercices: this._workout['program']['tusday'] )  ));   
                             }
                           },  
                        ),
                        
                        ListTile(
                          title: Text("Wednesday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                            subtitle: this._workout['program']['wensday'] != null? Text("${this._workout['program']['wensday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['wensday'] != null?  generateDayIcon(this._workout['program']['wensday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                            trailing: this._workout['program']['wensday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['wensday'] != null ){
                                Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Wednesday',exercices: this._workout['program']['wensday'] )  )); 
                             
                             }
                           },  
                        ),

                        ListTile(
                          title: Text("Thursday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                          subtitle: this._workout['program']['thursday'] != null? Text("${this._workout['program']['thursday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['thursday'] != null?  generateDayIcon(this._workout['program']['thursday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                           trailing: this._workout['program']['thursday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['thursday'] != null ){
                                 Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Thursday',exercices: this._workout['program']['thursday'] )  )); 
                                
                             }
                           },  
                        ),

                        ListTile(
                          title: Text("Friday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                          subtitle: this._workout['program']['friday'] != null? Text("${this._workout['program']['friday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['friday'] != null?  generateDayIcon(this._workout['program']['friday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                           trailing: this._workout['program']['friday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['friday'] != null ){
                                Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Friday',exercices: this._workout['program']['friday'] )  )); 
                                   
                             }
                           },  
                        ),
                        

                        ListTile(
                          title: Text("Saturday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                          subtitle: this._workout['program']['saturday'] != null? Text("${this._workout['program']['saturday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['saturday'] != null?  generateDayIcon(this._workout['program']['saturday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                            trailing: this._workout['program']['saturday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['saturday'] != null ){
                                Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Saturday',exercices: this._workout['program']['saturday'] )  )); 
                                  
                             }
                           },  
                        ),

                        ListTile(
                          title: Text("Sunday",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color.fromRGBO(251, 219, 20, 1)),),
                         subtitle: this._workout['program']['sanday'] != null? Text("${this._workout['program']['sanday']['split']}",style: TextStyle(fontSize: 15,color: Colors.white)) : Text("Rest day",style: TextStyle(fontSize: 15,color: Colors.white))  ,
                          leading: this._workout['program']['sanday'] != null?  generateDayIcon(this._workout['program']['sanday']['split'])   : Image.asset("assets/restday.PNG",width: 46,)  ,
                           trailing: this._workout['program']['sanday'] != null? Icon(Icons.arrow_forward_ios,color: Color.fromRGBO(251, 219, 20, 1),) : null,
                           onTap: (){
                             if( this._workout['program']['sanday'] != null ){
                                Navigator.push( context, MaterialPageRoute(builder: (BuildContext context) => ExercicesDetailsPage(day: 'Sunday',exercices: this._workout['program']['sanday'] )  )); 
                                  
                             
                             }
                           },  
                        ),
                        

                      ],
                    )
                    
            )
          ],
        ),
        )
        
        );
  }
}
