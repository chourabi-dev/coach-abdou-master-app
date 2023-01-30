import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlocRepetitions extends StatelessWidget {

  final int reps;
  final int pause;
  final BuildContext c;

  const BlocRepetitions({Key key, this.reps, this.pause, this.c}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(c).size.width;

    return Container(
      margin: EdgeInsets.only(bottom:15),
      child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right:7.5),
                    padding: EdgeInsets.all(15),
                    color: Colors.grey.shade900,
                    width:  ( (width - 30) / 2 ) - 7.5,
                    child: Text("${reps} reps",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                  Container(
                    margin: EdgeInsets.only(right:7.5),
                    padding: EdgeInsets.all(15),
                    color: Colors.grey.shade900,
                    width:  ( (width - 30) / 2 ) - 7.5,
                    child: Text("${pause}s  pause",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                  
                ],
              )
              );
  }
  
}