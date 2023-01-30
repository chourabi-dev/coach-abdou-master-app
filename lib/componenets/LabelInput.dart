
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelInput extends StatelessWidget {
  final double screenWidth;
  final String leftText;
  final String righTtext;
  

  const LabelInput({Key key, this.screenWidth, this.leftText, this.righTtext}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top:15,bottom: 0),
      width: screenWidth,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:15,right:15),
            width: (screenWidth - 15) / 2,
            child: Text(leftText,style: TextStyle(fontSize: 18, color: Colors.white),textAlign: TextAlign.start,),
          ),
          Container(
            width: (screenWidth - 15)  / 2,
            child: Text(righTtext,style: TextStyle(fontSize: 18, color: Colors.white),textAlign: TextAlign.end,),
          ),
          
        ],
      ),
    );
  }
  
}