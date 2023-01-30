import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/services/api.dart';

class ReportABugPage extends StatefulWidget {
  ReportABugPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ReportABugPageState createState() => _ReportABugPageState();
}

class _ReportABugPageState extends State<ReportABugPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = null;
  dynamic payments = null;
  dynamic _notifications = [];
  dynamic _reclamations = [];

  bool _errorLoading = false;

  List<dynamic> items = [];

  TextEditingController _editDescription = new TextEditingController();
  bool _validate = false;

  int title = 1;

  _showError() {
    setState(() {
      _errorLoading = true;
    });
  }

  _hideError() {
    setState(() {
      _errorLoading = false;
    });
  }

  _getMemberInformations() {
    setState(() {
      _isLoading = true;
      _errorLoading = false;
    });
    api.getUserData().then((response) {
      print(response.body);
      final body = json.decode(response.body);

      if (body['success']) {
        user = body['data'];
        payments = body['payments'];
        _notifications = body['notifications'];
        _reclamations = body['reclamations'];

        List<dynamic> _tmp = [];

        for (var rec in _reclamations) {
          _tmp.add(rec);
        }
        setState(() {
          items = _tmp;
        });

        print(payments);
      } else {
        _showError();
      }

      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _errorLoading = true;
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();

    api.updateNotificationsView().then((value) => print("ninja " + value.body));

    title = 1;
  }

  titleChangeF(val) {
    setState(() {
      title = val;
    });
  }


    _showAlert(String title,String message, String okButton) async {
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(message),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(okButton),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("signaler un problème"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 15,
                ),
                Container(
                  width: width,
                  child: Text(
                    "Qu'est-ce qui ne va pas !?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 15,
                ),
                Text(
                  "Tout d'abord, nous espérons que vous allez bien et en bonne santé.\nparlez-nous de vos problèmes, afin que nous puissions améliorer nos services, vos commentaires sont vraiment importants pour nous",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
                Container(
                  height: 15,
                ),
                
                Container(
                  height: 15,
                ),
                TextField(
                  controller: _editDescription,
                  maxLines: 2,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Décrivez votre problème',
                    errorText: _validate
                        ? 'Ce champ est requis'
                        : null,
                  ),
                ),
                Container(
                  height: 15,
                ),
                GestureDetector(
                  onTap: (){
                    print("sending");
                    String description = _editDescription.text;
                    if (description !="") {
                      //send
                      _editDescription.text="";
                      setState(() {
                        _isLoading = true;
                        _validate = false;
                      });

                     
                      api.reportBug(description).then((response){

                        final body = json.decode(response.body);
                      bool success = body['success'];
                      print(body);
                      
                      if (success) {
                        _showAlert("Merci", "Merci pour vos commentaires.", "ok");
                      } else {
                        _showAlert("Erreur", body['message'], "ok");
                      }


                      setState(() {
                        _isLoading = false;
                      });
                    }).catchError((e){
                      print(e.toString());
                    _showAlert("Erreur", "Une erreur s'est produite, vérifiez la connectivité de votre téléphone et réessayez.", "ok");
                      setState(() {
                        _isLoading = false;
                      });
                    });

                    }else{
                      setState(() {
                        _validate = true;
                      });
                    }
                  },
                  child: _isLoading ? CircularProgressIndicator() : FluidButton(text: "ENVOYER",),
                )
              ],
            ),
          ),
        ));
  }
}
