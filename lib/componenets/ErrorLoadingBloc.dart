import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorLoadingBloc extends StatelessWidget{

  final VoidCallback refresh;

  const ErrorLoadingBloc({Key key, this.refresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
      Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Something went wrong, please try again.",textAlign: TextAlign.center,),
            RaisedButton(child: Text("réessayer"), onPressed: (){
              refresh();
            },)

          ])),
      )

    );
  }
  
}