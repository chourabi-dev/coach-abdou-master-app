import 'dart:convert';

import 'package:coach_abdou/componenets/TrainingLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/GymAndPlanInfo.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/componenets/HomeUserCard.dart';
import 'package:coach_abdou/componenets/InovicesCard.dart';
import 'package:coach_abdou/componenets/MyNotificationsBloc.dart';
import 'package:coach_abdou/componenets/MyTickets.dart';
import 'package:coach_abdou/pages/AboutPage.dart';
import 'package:coach_abdou/pages/NotificationsPage.dart';
import 'package:coach_abdou/pages/PaymentsHistoryPage.dart';
import 'package:coach_abdou/pages/ReclamationPage.dart';
import 'package:coach_abdou/pages/ReportBug.dart';
import 'package:coach_abdou/pages/SignInPage.dart';
import 'package:coach_abdou/pages/WorkoutPageDetails.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComparatorPage extends StatefulWidget {
  ComparatorPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ComparatorPageState createState() => _ComparatorPageState();
}

class _ComparatorPageState extends State<ComparatorPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = [];
  dynamic payments = [];
  dynamic _notifications = [];
  dynamic _reclamtions = [];
  dynamic _workout;
  dynamic _progress;

  List<String> _weeks = new List<String>();
  dynamic selectedFirstWeek;
  String _selectedFirstWeekValue;
  dynamic selectedSecondWeek;
  String _selectedSecondWeekValue;
  
  int _selectedFirstWeekImageIndex = 0;
  String _firstWeekImageURL;

  int _selectedSecondWeekImageIndex = 0;
  String _secondtWeekImageURL;
  

  bool _errorLoading = false;

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
        _reclamtions = body['reclamations'];
        _workout = body['workout'];
        _progress = body['progress'];
        initWeeksList();
      } else {
        _showError();
      }

      setState(() {
        _isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _errorLoading = true;
        _isLoading = false;
      });
    });
  }

  Future<void> _refresherFunction() async {
    await api.getUserData().then((response) {
      final body = json.decode(response.body);
      if (body['success']) {
        setState(() {
          user = body['data'];
          payments = body['payments'];
          _notifications = body['notifications'];
          _reclamtions = body['reclamations'];
          _workout = body['workout'];
          _progress = body['progress'];
        });

        initWeeksList();
      } else {}
    });
  }

  void initWeeksList(){
    List<String> tmp = new List();

    for (var item in _progress) {
      tmp.add( item['week_number'].toString() );
    }


    setState(() {
      _weeks = tmp;
    });
  }

  void updateSelectedWeek(int index , String value){
    if (index == 0) {
      // updating first week

    for (var item in _progress) {
      if(item['week_number'].toString() == value){
        setState(() {
          selectedFirstWeek = item;
          _selectedFirstWeekValue = value;
          _firstWeekImageURL = selectedFirstWeek['front_body_image'];
        });
      }
    }

    }else{
      //updating seconf week
          for (var item in _progress) {
      if(item['week_number'].toString() == value){
        setState(() {
          selectedSecondWeek = item;
          _selectedSecondWeekValue = value;
          _secondtWeekImageURL = selectedSecondWeek['front_body_image'];
        });
      }
    }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();
      selectedFirstWeek = null;
      selectedSecondWeek = null;


  }

  void updateImageProvider(int i, int index){

    if(i == 0){
      // updating first week image
      switch (index) {
        case 0:
          setState(() {
            _firstWeekImageURL = selectedFirstWeek['front_body_image'];
          });
          break;
                  case 1:
          setState(() {
            _firstWeekImageURL = selectedFirstWeek['side_body_image'];
          });
          break;

                  case 2:
          setState(() {
            _firstWeekImageURL = selectedFirstWeek['back_body_image'];
          });
          break;
        default:
      }

    }else if(i==1){
      print("switching second");
            switch (index) {
        case 0:
          setState(() {
            _secondtWeekImageURL = selectedSecondWeek['front_body_image'];
          });
          break;
                  case 1:
          setState(() {
            _secondtWeekImageURL = selectedSecondWeek['side_body_image'];
          });
          break;

                  case 2:
          setState(() {
            _secondtWeekImageURL = selectedSecondWeek['back_body_image'];
          });
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.blueGrey.shade900),
      child: RefreshIndicator(
        onRefresh: _refresherFunction,
        child: ListView(
          children: [
            // container profile

            !_isLoading
                ?

                // check for loading error
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: !_errorLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: w,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "COMPARE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(251, 219, 20, 1)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 15),
                                height: 3,
                                color: Colors.white,
                              ),
                              Container(
                                height: 30,
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /* side 1  */
                                  Container(
                                      padding: EdgeInsets.only(left:15,right:7.5),
                                      width: (w)*0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left:10,right:15),
                                            color: Colors.white,
                                            width: w,
                                            child: DropdownButton<String>(
                                              hint: Container(width: (w - 150) *0.5, child: Text('Select a week'),),
                                              value: _selectedFirstWeekValue,
                                            items: _weeks.map((String value) {
                                              return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text('Week ${value}'),
                                              );
                                            }).toList(),
                                            onChanged: (v) {
                                              updateSelectedWeek(0,v);
                                            },
                                          ),
                                          ),
                                            Container(
                                            height: 15,
                                          ),


                                        

                                          // view
                                          Container(
                                            height: h*0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                              
                                            ),
                                            child: selectedFirstWeek == null ?
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: w,
                                                  child: Icon(Icons.add,color:  Color.fromRGBO(251, 219, 20, 1),size: 50,),
                                                )
                                            ],)
                                            :
                                            Container(
                                              child: 

                                              PhotoViewGallery.builder(
                                                scrollPhysics: const BouncingScrollPhysics(),
                                                builder: (BuildContext context, int index) {
                                                  return PhotoViewGalleryPageOptions(
                                                    imageProvider: NetworkImage(_firstWeekImageURL),
                                                    initialScale: PhotoViewComputedScale.covered * 1,
                                                    
                                                  );
                                                },
                                                itemCount: 3,
                                                loadingBuilder: (context, event) => Center(
                                                  child: Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    child: CircularProgressIndicator(
                                                      value: event == null
                                                          ? 0
                                                          : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                                                    ),
                                                  ),
                                                ),
                                                onPageChanged: (int i){
                                                  updateImageProvider(0,i);
                                                },
                                              )


                                            )
                                            
                                          ),

                                          Container(height: 25,),

                                         selectedFirstWeek != null ? Row(children: [
                                           Container(
                                            width: ((w-30) * 0.5) * 0.4,
                                            child: Text(
                                                "Weight",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                          ),Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            width: ((w-55) * 0.5) * 0.6,
                                            child: Text(
                                                "${selectedFirstWeek['weight']} kg",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey.shade900),
                                              ),
                                          )



                                         ],):Container(),


                                          Container(height: 25,),

                                         selectedFirstWeek != null ? Row(children: [
                                           Container(
                                            width: ((w-30) * 0.5) * 0.4,
                                            child: Text(
                                                "Waist",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                          ),Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            width: ((w-55) * 0.5) * 0.6,
                                            child: Text(
                                                "${selectedFirstWeek['waist_size']} cm",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey.shade900),
                                              ),
                                          )



                                         ],):Container()


                                        ],
                                      ),
                                  ),


                                  // end of side 1

                                   /* side 2  */
                                  Container(
                                      padding: EdgeInsets.only(left:15,right:7.5),
                                      width: (w)*0.5,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left:10,right:15),
                                            color: Colors.white,
                                            width: w,
                                            child: DropdownButton<String>(
                                              hint: Container(width: (w - 150) *0.5, child: Text('Select a week'),),
                                              value: _selectedSecondWeekValue,
                                            items: _weeks.map((String value) {
                                              return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text('Week ${value}'),
                                              );
                                            }).toList(),
                                            onChanged: (v) {
                                              updateSelectedWeek(1,v);
                                            },
                                          ),
                                          ),
                                            Container(
                                            height: 15,
                                          ),


                                        

                                          // view
                                          Container(
                                            height: h*0.4,
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                              
                                            ),
                                            child: selectedSecondWeek == null ?
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: w,
                                                  child: Icon(Icons.add,color:  Color.fromRGBO(251, 219, 20, 1),size: 50,),
                                                )
                                            ],)
                                            :
                                            Container(
                                              child: PhotoViewGallery.builder(
                                                scrollPhysics: const BouncingScrollPhysics(),
                                                builder: (BuildContext context, int index) {
                                                  return PhotoViewGalleryPageOptions(
                                                    imageProvider: NetworkImage(_secondtWeekImageURL),
                                                    initialScale: PhotoViewComputedScale.covered * 1,
                                                    
                                                  );
                                                },
                                                itemCount: 3,
                                                loadingBuilder: (context, event) => Center(
                                                  child: Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    child: CircularProgressIndicator(
                                                      value: event == null
                                                          ? 0
                                                          : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                                                    ),
                                                  ),
                                                ),
                                                onPageChanged: (int i){
                                                  updateImageProvider(1,i);
                                                },
                                              )

                                            )
                                            
                                          ),

                                          Container(height: 25,),

                                         selectedSecondWeek != null ? Row(children: [
                                           Container(
                                            width: ((w-30) * 0.5) * 0.4,
                                            child: Text(
                                                "Weight",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                          ),Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            width: ((w-55) * 0.5) * 0.6,
                                            child: Text(
                                                "${selectedSecondWeek['weight']} kg",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey.shade900),
                                              ),
                                          )



                                         ],):Container(),


                                          Container(height: 25,),

                                         selectedSecondWeek != null ? Row(children: [
                                           Container(
                                            width: ((w-30) * 0.5) * 0.4,
                                            child: Text(
                                                "Waist",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                          ),Container(
                                            padding: EdgeInsets.all(10),
                                            color: Colors.white,
                                            width: ((w-55) * 0.5) * 0.6,
                                            child: Text(
                                                "${selectedSecondWeek['waist_size']} cm",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey.shade900),
                                              ),
                                          )



                                         ],):Container()


                                        ],
                                      ),
                                  ),


                                  




                                ],
                              ),














                            ],
                          )
                        : ErrorLoadingBloc(
                            refresh: () {
                              this._getMemberInformations();
                            },
                          ),
                  )
                : HomeLoader(message: "Loading..."),
          ],
        ),
      ),
    ));
  }
}
