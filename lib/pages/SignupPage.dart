import 'dart:convert';

import 'package:coach_abdou/componenets/AboutBloc.dart';
import 'package:coach_abdou/componenets/LabelInput.dart';
import 'package:coach_abdou/pages/UpdateUserPhotos.dart';
import 'package:coach_abdou/pages/WelcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  Api api = new Api();

  TextEditingController _fullnameController = new TextEditingController();
  bool _errFullname = false;
  String _errFullnameText = '';

  TextEditingController _adressController = new TextEditingController();
  bool _errAdress = false;
  String _errAdressText = '';

  TextEditingController _emailController = new TextEditingController();
  bool _errEmail = false;
  String _errEmailText = '';

  TextEditingController _passwordController = new TextEditingController();
  bool _errPassword = false;
  String _errPasswordText = '';

  TextEditingController _confirmPasswordController = new TextEditingController();
  bool _errConfirmPassword = false;
  String _errConfirmPasswordText = '';
  String _sexValue="Male";

  TextEditingController _phoneController = new TextEditingController();
  bool _errPhone = false;
  String _errPhoneText = '';

  TextEditingController _ageController = new TextEditingController();
  bool _errAge = false;
  String _errAgeText = '';

  TextEditingController _heightController = new TextEditingController();
  bool _errHeight = false;
  String _errHeightText = '';

  TextEditingController _waistController = new TextEditingController();
  bool _errWaist = false;
  String _errWaistText = '';

  TextEditingController _weightController = new TextEditingController();
  bool _errWeight = false;
  String _errWeightText = '';

  TextEditingController _sinceController = new TextEditingController();
  bool _errSince = false;
  String _errSinceText = '';

  TextEditingController _timeController = new TextEditingController();
  bool _errTime = false;
  String _errTimeText = '';


    TextEditingController _dietController = new TextEditingController();
  bool _errDiet = false;
  String _errDietText = '';
  

    TextEditingController _foodController = new TextEditingController();
  bool _errFood= false;
  String _errFoodText = '';
  

    TextEditingController _healthController = new TextEditingController();
  bool _errHealth = false;
  String _errHealthText = '';
  

    TextEditingController _goalController = new TextEditingController();
    bool _errGoal = false;
    String _errGoalText = '';
  

    TextEditingController _moreController = new TextEditingController();

  



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkForAuth();
  }

  _checkForAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token == null) {
    } else {}
  }


void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Container(
          color: Colors.blueGrey.shade900,
          height: 120,
          padding: EdgeInsets.all(20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CircularProgressIndicator(),
            Container(height: 15,),
            new Text("Please wait...",style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
          ],
        ),
        ),
      );
    },
  );
}


Future<void> _showAlert(String title,String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(title,style: TextStyle(color: Colors.white),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message,style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  _checkInputs() {
    String fullname = _fullnameController.text;
    String adress = _adressController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    
    String age = _ageController.text;
    String height = _heightController.text;
    String weight = _weightController.text;
    String waist = _waistController.text;
    String since = _sinceController.text;
    String time = _timeController.text;

    String diet = _dietController.text;
    String food = _foodController.text;
    String health = _healthController.text;
    String goal = _goalController.text;
    String more = _moreController.text;
    
    
    
    String password = _passwordController.text;
    String passwordConfirmation = _confirmPasswordController.text;
    

    if (fullname == '') {
      setState(() {
        _errFullnameText = 'This feild is required.';
        _errFullname = true;
      });
    } else if (fullname.length < 4) {
      setState(() {
        _errFullnameText = 'Please enter a valid name.';
        _errFullname = true;
      });
    } else {
      // fullname is good
      setState(() {
        _errFullnameText = '';
        _errFullname = false;
      });

      if (adress == '') {
        setState(() {
          _errAdressText = 'This feild is required.';
          _errAdress = true;
        });
      } else if (adress.length < 4) {
        setState(() {
          _errAdressText = 'Please enter a valid adress.';
          _errAdress = true;
        });
      } else {
        setState(() {
          _errAdressText = '';
          _errAdress = false;
        });

        if (email == '') {
          setState(() {
            _errEmailText = 'This feild is required.';
            _errEmail = true;
          });
        } else if (email.length < 4) {
          setState(() {
            _errEmailText = 'Please enter a valid email.';
            _errEmail = true;
          });
        } else {
          setState(() {
            _errEmailText = '';
            _errEmail = false;
          });

          if (password == '') {
            setState(() {
              _errPasswordText = 'This feild is required.';
              _errPassword = true;
            });
          } else if (password.length < 8) {
            setState(() {
              _errPasswordText =
                  'Please enter a valid password ( min 8 chars ).';
              _errPassword = true;
            });
          } else {
            setState(() {
              _errPasswordText = '';
              _errPassword = false;
            });

            if (passwordConfirmation == '') {
              setState(() {
                _errConfirmPasswordText = 'This feild is required.';
                _errConfirmPassword = true;
              });
            } else if (passwordConfirmation != password) {
              setState(() {
                _errConfirmPasswordText = 'Passwords do not match.';
                _errConfirmPassword = true;
              });
            } else {
              setState(() {
                _errConfirmPasswordText = '';
                _errConfirmPassword = false;
              });
              

              if (phone.length < 7) {
                
                setState(() {
                _errPhoneText = 'This feild is required.';
                _errPhone = true;
              });


              } else {
                /** safe to send API request */
                setState(() {
                _errPhoneText = '';
                _errPhone = false;
              });

              if (age == '') {
                setState(() {
                  _errAgeText = 'This feild is required.';
                  _errAge = true;
                });
              } else{
                setState(() {
                  _errAgeText = '';
                  _errAge = false;
                });

                  if (height == '') {
                  setState(() {
                    _errHeightText = 'This feild is required.';
                    _errHeight = true;
                  });
                } else{
                  setState(() {
                    _errHeight = false;
                  });


                if (weight == '') {
                  setState(() {
                    _errWeightText = 'This feild is required.';
                    _errWeight = true;
                  });
                } else{
                  setState(() {
                    _errWeight = false;
                  });


                if (waist == '') {
                  setState(() {
                    _errWaistText = 'This feild is required.';
                    _errWaist = true;
                  });
                } else{
                  setState(() {
                    _errWaist = false;
                  });


                if (time == '') {
                  setState(() {
                    _errTimeText = 'This feild is required.';
                    _errTime= true;
                  });
                } else{
                  setState(() {
                    _errTime = false;
                  });


                  if (diet == '') {
                  setState(() {
                    _errDietText = 'This feild is required.';
                    _errDiet= true;
                  });
                  } else{
                    setState(() {
                      _errDiet = false;
                    });



                    if (food == '') {
                  setState(() {
                    _errFoodText = 'This feild is required.';
                    _errFood= true;
                  });
                  } else{
                    setState(() {
                      _errFood = false;
                    });


                if (health == '') {
                  setState(() {
                    _errHealthText = 'This feild is required.';
                    _errHealth= true;
                  });
                  } else{
                    setState(() {
                      _errHealth = false;
                    });


                if (goal == '') {
                  setState(() {
                    _errGoalText = 'This feild is required.';
                    _errGoal= true;
                  });
                  } else{
                    setState(() {
                      _errGoal = false;
                    });





                    /** we good to go  */

                     _onLoading();
              api.signupUser(fullname,phone, _sexValue, adress, email, password,age,height,weight,waist,since,time,diet,food,health,goal,more ).then((response)async {
                Navigator.pop(context);
                
                if (response != null) {
                  final body = json.decode(response.body);
                  print(body);

                  if (body['success']) {
                    
                    //Navigator.pop(context);

                    //save id memeber and go update photos
                    int idMember = body['idMember'];
                    String token = body['token'];
                    
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setInt('id', idMember);
                    await prefs.setString('token', token);
                    
                    _showAlert('Congratulations', body['message']);
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UpdateUserPhtotPage()));




                    
                    
                  } else {
                     
                      _showAlert('Error', body['message']);
                    
                  }

                }else{
                  
                  print("good fail");
                  _showAlert('Error', 'Something went wrong while trying to make the request, please try again.');
                
                }

                
              }).catchError((err){
                //Navigator.pop(context);
                print("fail");
                print(err);
                _showAlert("title", err.toString());
                _showAlert('Error', 'Something went wrong while trying to make the request, please try again.');
                
              });


                  }



                  }



                  }



                  }
                  
                }




                }




                }



                }
               
              }
               


              
              }




            }
          }
        }

      }
    }
  }


  void _sexChange(String v){
    setState(() {
      _sexValue = v;
    });
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
                  "WELCOME!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(251, 219, 20, 1)),
                ),
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Please fill out the questionnaire form with accuracy, The more information provided will allow Abdou to build you a detailed custom plan.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                width: d,
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  "BASIC REQUIRED INFORMATION",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(251, 219, 20, 1)),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                height: 3,
                color: Colors.white,
              ),
              // fullname feild
              LabelInput(screenWidth: d,leftText: "Full Name",righTtext: 'الاسم بالكامل',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errFullname ? _errFullnameText : null,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Text("Gender / الجنس",style: TextStyle(color: Colors.white,fontSize: 17),),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  
                  new Radio(
                   
                    value: "Male",
                    groupValue: _sexValue ,
                    onChanged: _sexChange,
                    activeColor: Colors.yellowAccent,
                  ),
                  Text("Male / ذكر", style: TextStyle(color: Colors.white,fontSize: 17),),
                  new Radio(
                    value: "Female",
                    groupValue: _sexValue,
                    onChanged: _sexChange,
                    activeColor: Colors.yellowAccent,
                  ),
                  Text("Female / أنثى", style: TextStyle(color: Colors.white,fontSize: 17),),
                ],),
              ),


              // adress feild
              

                LabelInput(screenWidth: d,leftText: "Address",righTtext: "العنوان",),
                Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  
                  controller: _adressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errAdress ? _errAdressText : null,
                  ),
                ),
              ),
              // adress feild

              LabelInput(screenWidth: d,leftText: "Phone number",righTtext: "رقم الهاتف",),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _phoneController,
                  
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errPhone ? _errPhoneText : null,
                  ),
                ),
              ),
              
              // fullname feild
              LabelInput(screenWidth: d,leftText: "Email",righTtext: 'البريد الإلكتروني',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errEmail ? _errEmailText : null,
                  ),
                ),
              ),
              // fullname feild
              LabelInput(screenWidth: d,leftText: "Password",righTtext: 'كلمه السر',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errPassword ? _errPasswordText : null,
                  ),
                ),
              ),
              // fullname feild

              LabelInput(screenWidth: d,leftText: "Confirm password",righTtext: 'تأكيد كلمة المرور',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                 
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText:
                        _errConfirmPassword ? _errConfirmPasswordText : null,
                  ),
                ),
              ),
              


              /*** second phase ***/




              /*** end of second phase ***/
              // adress feild

              LabelInput(screenWidth: d,leftText: "Age",righTtext: 'العمر',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errAge ? _errAgeText : null,
                  ),
                ),
              ),

              // adress feild

              LabelInput(screenWidth: d,leftText: "Height",righTtext: 'الطول',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errHeight ? _errHeightText : null,
                  ),
                ),
              ),

              //  feild
              LabelInput(screenWidth: d,leftText: "Weight",righTtext: 'الوزن',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errWeight ? _errWeightText : null,
                  ),
                ),
              ),


              //  feild
              LabelInput(screenWidth: d,leftText: "Waist",righTtext: 'قياس الخصر',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  controller: _waistController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errWaist ? _errWaistText : null,
                  ),
                ),
              ),

               //  feild
               LabelInput(screenWidth: d,leftText: "How long have you been training",righTtext: 'منذ متى كنت تتدرب',),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _sinceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errSince ? _errSinceText : null,
                  ),
                ),
              ),


              //  feild

            LabelInput(screenWidth: d,leftText: "What time do you usually go to the gym",righTtext: 'في أي ساعة تتدَرب',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _timeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errTime ? _errTimeText : null,
                  ),
                ),
              ),




            //  feild

            LabelInput(screenWidth: d,leftText: "Your last Diet plan?\nSupplement?",righTtext: 'آخر برنامج غذائي إتبعته؟  \nمع مكمالت؟ ',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _dietController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errDiet ? _errDietText : null,
                  ),
                ),
              ),


               //  feild
  
            LabelInput(screenWidth: d,leftText: "Are you allergic to a certain food?",righTtext: 'هل لديك حساسية من أكل معين؟ ',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _foodController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errFood ? _errFoodText : null,
                  ),
                ),
              ),



               //  feild

            LabelInput(screenWidth: d,leftText: "Do you have injury or chronic disease?",righTtext: 'هل لديك إصابة أو مرض مزمن؟ ',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _healthController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errHealth ? _errHealthText : null,
                  ),
                ),
              ),


               //  feild

            LabelInput(screenWidth: d,leftText: "Your goal",righTtext: 'ماهو هدفك؟',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _goalController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    errorText: _errGoal ? _errGoalText : null,
                  ),
                ),
              ),


               //  feild

            LabelInput(screenWidth: d,leftText: "Any additional information?",righTtext: 'هل تريد إضافة أي معلومات ',),
             
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: _moreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    enabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    focusedBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.white)),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),

              


              Container(
                height: 15,
              ),
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
                      _checkInputs();
                    },
                    color: Color.fromRGBO(251, 219, 20, 1),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ),
              ),


              AboutBloc(screenWidth: d,),
              Container(height: 50,)
            ],
          )),
    );
  }
}
