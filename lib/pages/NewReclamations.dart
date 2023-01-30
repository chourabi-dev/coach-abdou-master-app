import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/FluidButton.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/services/api.dart';

class NewReclamationPage extends StatefulWidget {
  NewReclamationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewReclamationPageState createState() => _NewReclamationPageState();
}

class _NewReclamationPageState extends State<NewReclamationPage> {
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
          backgroundColor: Colors.purple,
          title: Text("New complaint"),
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
                    "What's wrong !?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 15,
                ),
                Text(
                  "First of all, we hope you are well and healthy. \ Ntell us about your problems, so that we can improve our services, your feedback is really important to us.",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
                Container(
                  height: 15,
                ),
                Column(
                  children: [
                      
                    ListTile(
                      leading: Radio(
                        value: 1,
                        groupValue: title,
                        activeColor: Colors.purpleAccent,
                        onChanged: (val) {
                          print("Radio $val");
                          titleChangeF(val);
                        },
                      ),
                      title: Text("Services"),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 2,
                        groupValue: title,
                        activeColor: Colors.purpleAccent,
                        onChanged: (val) {
                          print("Radio $val");
                          titleChangeF(val);
                        },
                      ),
                      title: Text("Training"),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 3,
                        groupValue: title,
                        activeColor: Colors.purpleAccent,
                        onChanged: (val) {
                          print("Radio $val");
                          titleChangeF(val);
                        },
                      ),
                      title: Text("Diet"),
                    ),
                    ListTile(
                      leading: Radio(
                        value: 4,
                        groupValue: title,
                        activeColor: Colors.orangeAccent,
                        onChanged: (val) {
                          print("Radio $val");
                          titleChangeF(val);
                        },
                      ),
                      title: Text("Other"),
                    ),






                  ],
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
                    labelText: 'Describe your problem',
                    errorText: _validate
                        ? 'This field is required'
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

                      String strTitle = "";
                      switch (title) {
                        case 1:
                          strTitle ="Services";
                          break;
                          case 2:
                          strTitle ="Training";
                          break;
                          case 3:
                          strTitle ="Diet";
                          break;
                          case 4:
                          strTitle ="Other";
                          break;
                          
                        default:
                      }

                      api.newReclamation(strTitle, description).then((response){

                        final body = json.decode(response.body);
                      bool success = body['success'];
                      print(body);
                      
                      if (success) {
                        _showAlert("Thank you", "Thanks for your feedback, we'll get back to you soon.", "ok");
                      } else {
                        _showAlert("Error", body['message'], "ok");
                      }


                      setState(() {
                        _isLoading = false;
                      });
                    }).catchError((e){
                      print(e.toString());
                    _showAlert("Error", "An error has occurred, check your phone's connectivity and try again.", "ok");
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
                  child: _isLoading ? CircularProgressIndicator() : FluidButton(text: "SEND NOW",),
                )
              ],
            ),
          ),
        ));
  }
}
