
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutBloc extends StatelessWidget {
  final double screenWidth;

  const AboutBloc({Key key, this.screenWidth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
                width: screenWidth,
                child: Text("Developed by CHOURABI TAHER", style: TextStyle(color: Colors.grey.shade400),textAlign: TextAlign.center,),
    );
  }
  
}