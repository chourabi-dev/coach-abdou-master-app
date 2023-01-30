import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLoader extends StatelessWidget {
  final message;

  const HomeLoader({Key key, this.message}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return       Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator()
          ])),
    );
  }
  
}