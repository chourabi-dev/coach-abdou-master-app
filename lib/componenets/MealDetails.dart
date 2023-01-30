
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {

  final dynamic meal;
  MealDetails({Key key, this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(meal['description']);

    double width = MediaQuery.of(context).size.width;

    return  Container(
      child: Column(
        children: <Widget>[
           Container(
                  width: width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    'Meal ${meal['number']+1}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 219, 20, 1)),
                  ),
                ),
                           Container(
                  width: width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Text(
                    meal['description'] ,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300, ),
                  ),
                ),
                
                                Container(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                  height: 3,
                  color: Colors.white,
                ),
          
        ],
      ),
    );
  }
  
}