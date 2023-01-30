

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GymAndPlanInfo extends StatelessWidget{

  final BuildContext c;
  final memberId;
  final price;
  final planName;
  final gymName;
  final reduction;
  final devoir;

  const GymAndPlanInfo({Key key, this.c, this.memberId, this.price, this.planName, this.gymName, this.reduction, this.devoir}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(c).size.width;
    // TODO: implement build
    return Container(
              
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(c).size.width,
              decoration: BoxDecoration(

                  
                color: Colors.white,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( width: MediaQuery.of(c).size.width, child: Text("$gymName",style: TextStyle(color: Colors.blue.shade400 ,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
                 Container(height: 15,),
                  
                  

                  Row(children: [
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text("Code membre",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text(": $memberId ",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    
                  ],),



                  Row(children: [
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text("Prix",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text(": $price TND ",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    
                  ],),

                  Row(children: [
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text("Réduction",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text(": $reduction TND ",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    
                  ],),

                  Row(children: [
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text("Devoir",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text(": $devoir TND ",style: TextStyle(color: devoir == 0 ?Colors.grey.shade800 :Colors.redAccent , fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    
                  ],),

                   Row(children: [
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text("plan",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: (screenWidth - 60 ) /2,
                      child:  Text(": $planName ",style: TextStyle(color: Colors.grey.shade800,fontSize: 16,fontWeight: FontWeight.w400),),
                    ),
                    
                  ],)
                  
                  
                  
            ],),);
  }
  
}