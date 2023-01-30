

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/PaymentsHistoryPage.dart';

class InovicesCard extends StatelessWidget{

  final BuildContext c;
  final count;


  const InovicesCard({Key key, this.c, this.count}) : super(key: key);
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
          MaterialPageRoute(builder: (context) => PaymentsHistoryPage()),
        );
      },
      child:     Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(c).size.width,
              
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Historique des paiements",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("$count historique(s)",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w400),),
                  
                  
                  
            ],),),
    ));






  }
  
}