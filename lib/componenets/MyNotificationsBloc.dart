

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/pages/NotificationsPage.dart';

class MyNotifications extends StatelessWidget{

  final BuildContext c;
  final dynamic notifications;
  final VoidCallback refresh;



  const MyNotifications({Key key, this.c, this.notifications, this.refresh}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int _nonSeennotifications = 0;

    for (var not in notifications) {
      if (not['is_seen_notification'] == 0) {
        _nonSeennotifications+=1;
      }
    }

    // TODO: implement build
    return 
     Container(
              margin: EdgeInsets.all(15),
              child:

    RaisedButton( 
      elevation: 2,
      color: Colors.white,
      onPressed: () async {
        

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsPage()),
        );
        refresh();
      },
      child:     Container(
              width: MediaQuery.of(c).size.width,
              padding: EdgeInsets.all(15),
              
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mes notifications (${notifications.length})",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                  Text("${_nonSeennotifications} notification(s) ",
                  style: TextStyle(color:  _nonSeennotifications ==0 ?  Colors.grey : Colors.redAccent,fontSize: 16,fontWeight: FontWeight.w400),
                ),
                  
                  
                  
            ],),),
    ));
    
    

  }
  
}