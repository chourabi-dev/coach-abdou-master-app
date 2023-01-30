import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

 

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("À propos"),
        ),
        body: SingleChildScrollView(
          
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                ),
                Container(
                  child: Image.asset('assets/logo.png'),
                ),
                Container(
                  height: 15,
                ),
                Container(
                  width: width,
                  child: Text(
                    "GYMMY SPACE Mobile app",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 15,
                ),
                                Container(
                  width: width,
                  child: Text(
                    "v1.0.0",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 15,
                ),
                Text(
                  
                  "tous les droits sont réservés ${new DateTime.now().year}. ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                Container(
                  height: 15,
                ),
                Text(
                  
                  "Cette application est développée et conçue par. ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                Container(
                  height: 15,
                ), Container(
                  width: width,
                  child: Text(
                    "Chourabi Taher",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                ),
                

                
              ],
            ),
          ),
        ));
  }
}
