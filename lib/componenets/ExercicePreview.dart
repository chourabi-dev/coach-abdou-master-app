import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExercicePreview extends StatelessWidget {
  final dynamic exercie;
  final bool showSets;
  final bool isSuperSet;

  const ExercicePreview({Key key, this.exercie, this.showSets, this.isSuperSet})
      : super(key: key);

  Future<void> _launchInBrowser(String url) async {
    launch(url.trim(), forceSafariVC: false, forceWebView: false).then((value) {
      print("showed");
    }).catchError((err) {
      print(err);
    });
  }

  Widget labelCounter(
    dynamic sets,
    dynamic reps,
    dynamic pause,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${sets} ",
          style: TextStyle(
            color: Color.fromRGBO(251, 219, 20, 1),
          ),
        ),
        Text("Sets"),
        Container(
          width: 10,
        ),
        Text(
          "${reps} ",
          style: TextStyle(
            color: Color.fromRGBO(251, 219, 20, 1),
          ),
        ),
        Text("Reps"),
        Container(
          width: 10,
        ),
        Text(
          "${pause}s ",
          style: TextStyle(
            color: Color.fromRGBO(251, 219, 20, 1),
          ),
        ),
        Text("Rest"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  this.isSuperSet ? 
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ):
                  Container(),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      exercie['title_exercice'],
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 19),
                    ),
                  )
                ],
              ),
              showSets
                  ? Container(
                      child: labelCounter(
                          exercie['sets'], exercie['reps'], exercie['pause']),
                    )
                  : Container()
            ],
          ),
          Container(
            height: 20,
          ),
          ListTile(
            leading: Text(
              "Target :",
              style: TextStyle(
                color: Color.fromRGBO(251, 219, 20, 1),
              ),
            ),
            title: Text(
              exercie['body_section'],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),
          ListTile(
            leading: Text(
              "Notes :",
              style: TextStyle(
                color: Color.fromRGBO(251, 219, 20, 1),
              ),
            ),
            title: Text(
              exercie['instruction_exercice'],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ),

//isSuperSet ?  Colors.red.shade900: null

          Container(
            height: 20,
          ),
          ListTile(
            leading: Text(
              "Link",
              style: TextStyle(
                color: Color.fromRGBO(251, 219, 20, 1),
              ),
            ),
            title: Text(
              exercie['url'],
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            onTap: () {
              try {
                _launchInBrowser(exercie['url']);
              } catch (e) {
                
              }
            },
          ),

   

          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
