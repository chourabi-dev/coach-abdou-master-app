

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/ReclamationPage.dart';

class MyTickets extends StatelessWidget{

  final BuildContext c;
  final int count;  
  final VoidCallback refresh;

  const MyTickets({Key key, this.c, this.count, this.refresh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


return Container(
              margin: EdgeInsets.all(15),
              child:

    RaisedButton( 
      elevation: 2,
      color: Colors.white,
      onPressed: () async {
        

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReclamationPage()),
        );
        refresh();
      },
      child:Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(c).size.width,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mes réclamations",style: TextStyle(color: Color.fromRGBO(0, 24, 94, 1),fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("$count réclamation(s)",style: TextStyle(color: Color.fromRGBO(0, 80, 215, 1),fontSize: 16,fontWeight: FontWeight.w400),),

                  
                  
            ],),),
    ));




  }
  
}