import 'dart:convert';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/componenets/LabelInput.dart';
import 'package:coach_abdou/pages/SignupPage.dart';
import 'package:coach_abdou/pages/UpdateUserPhotos.dart';
import 'package:coach_abdou/pages/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndConditionsPage extends StatefulWidget {
  TermsAndConditionsPage({Key key}) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _accepted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.blueGrey.shade900),
          child: ListView(
            children: <Widget>[
              Container(
                width: d,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                child: Text(
                  "Terms & conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(251, 219, 20, 1)),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "ليس هناك إمكانية إرجاع المبلغ بعد تسليم البرنامج.",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "يتعهد المتدرب / المتدربة بإتباع البرنامج 100٪؜",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "إذا لم يتم إرسال الصور و الوزن مدة أسبوعين متتاليين سيتم إيقاف الاشتراك و يجب الدفع مرة أخرى إذا أراد المتدرب / المتدربة إكمال البرنامج.",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "لديك إمكانية إيقاف الاشتراك مره وآحده بسبب المرض لا غير. ",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "There is no possibility of refunding after getting the program.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "The trainee must follow the program 100%.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "If the photos and weights are not sent for two consecutive weeks, the subscription will be suspended and the payment must be made again if the trainee wants to complete.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "The trainee have the possibility to stop the subscription once and only for health reasons.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                height: 15
              ),
              
              
              

              

              
              

              Container(
                child: Row(
                  children: [
                    Checkbox(
                      value: _accepted,
                      onChanged: (value){
                        setState(() {
                          _accepted = value;
                        });
                      },
                    ),

                    Container(
                width: d - 80,
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Text(
                  "I accept the terms and conditions",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )




                  ],
                ),
              ),



              _accepted == true ?
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                width: d,
                height: 80,
                child: Container(
                  height: 70,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                  width: d,
                  child: FlatButton(
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade900),
                    ),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (context){
                      return new SignUpPage();
                    }));
                    },
                    color: Color.fromRGBO(251, 219, 20, 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ),
              ):
              Container()
              
              
              
              
              ,
              AboutBloc(
                screenWidth: d,
              ),
              Container(
                height: 50,
              )
            ],
          )),
    );
  }
}
