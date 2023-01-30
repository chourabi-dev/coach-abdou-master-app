
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackButtonProject extends StatelessWidget {


  const BackButtonProject({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(left:10,top:10),
        child: Row(
      children: [
        Icon(Icons.arrow_back_ios,color: Color.fromRGBO(251, 219, 20, 1)),
        Text("Back", style: TextStyle(color: Color.fromRGBO(251, 219, 20, 1)),textAlign: TextAlign.center,)
      ],
    ),
      )
    );
    
  }
  
}