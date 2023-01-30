
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/ErrorLoadingBloc.dart';
import 'package:coach_abdou/componenets/HomeLoader.dart';
import 'package:coach_abdou/services/api.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  bool _isLoading = false;
  Api api = new Api();

  dynamic user = [];
  dynamic payments = [];
  dynamic _notifications = [];
  dynamic _reclamtions = [];
  dynamic _workout;
  dynamic _progress ;
  List<FlSpot> _weightSpots = <FlSpot>[FlSpot(0,0)];
  List<FlSpot> _waistSpots = <FlSpot>[FlSpot(0,0)];
  

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
        initWeightsSpostsList();
        initWaistsSpostsList();
        
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


  void initWeightsSpostsList(){
      List<FlSpot> tmp = new List();
    for (var progress in _progress) {
      tmp.add(FlSpot(progress['week_number'] / 1 ,progress['weight'] / 1));
    }

    setState(() {
      _weightSpots = tmp;
    });
  }

    void initWaistsSpostsList(){
      List<FlSpot> tmp = new List();
    for (var progress in _progress) {
      tmp.add(FlSpot(progress['week_number'] / 1 ,progress['waist_size'] / 1));
    }

    setState(() {
      _waistSpots = tmp;
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

        initWeightsSpostsList();
        initWaistsSpostsList();

      } else {}
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMemberInformations();
  }

  double maxWeightValue(){
    double max = 0;

    for (var prog in _progress) {
      if ( (prog['weight'] ) > max ) {
        max = (prog['weight'] / 1);
      }
    }

    return (max+20);
  }



  double maxWaistValue(){
    double max = 0;

    for (var prog in _progress) {
      if ( (prog['waist_size'] ) > max ) {
        max = (prog['waist_size'] / 1);
      }
    }

    return (max+20);
  }




  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
        
        body: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade900
          ),
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
                                children: [
                                  Container(
                                width: w,
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "STATISTIC",
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
                                width: w,
                                padding: EdgeInsets.all(15),
                                child: Text(
                                    "Weight ( kg / week )",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                              ),

                              Container(
                                width: w,
                                padding: EdgeInsets.only(left:0,right:30),
                                child: LineChart(
                                LineChartData(
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      margin: 2,
                                      getTitles: (v){
                                        return ''+v.round().toString();
                                      },
                                      getTextStyles: (v)=>TextStyle(
                                        color: Colors.white
                                      ),
                                      reservedSize: 10
                                    ),
                                    leftTitles: SideTitles(
                                      interval: 20,
                                      showTitles: true,
                                      margin: 10,
                                      getTitles: (v){
                                        return v.round().toString();
                                      },
                                      getTextStyles: (v)=>TextStyle(
                                        color: Colors.white
                                      ),
                                      reservedSize: 39
                                    ),
                                  ),
                                  minX: 1,
                                  maxX: _progress.length/1,
                                  minY: 0,
                                  maxY: maxWeightValue(),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: false,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value){
                                      return FlLine(color: Colors.red,strokeWidth: 1);
                                    },
                                    getDrawingVerticalLine: (value){
                                      return FlLine(color: Colors.yellow,strokeWidth: 1);
                                    }
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                    //border: Border.all(color: Colors.blue,width: 5)
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      isCurved: true,
                                      barWidth: 5,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        colors: <Color>[
                                          Color.fromRGBO(251, 219, 20, 1),
                                          Color.fromRGBO(251, 219, 20, 1)
                                        ].map((color) => color.withOpacity(0.3) ).toList()
                                      ),
                                      colors: <Color>[
                                        Color.fromRGBO(251, 219, 20, 1)
                                      ],
                                    spots: _weightSpots
                                  )
                                  
                                  ]

                                )
                              ),
                              ),


                              /*** */
                              Container(
                                width: w,
                                padding: EdgeInsets.all(15),
                                child: Text(
                                    "Waist ( cm / week )",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                              ),


                              Container(
                                width: w,
                                padding: EdgeInsets.only(left:0,right:30),
                                child: LineChart(
                                LineChartData(
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: SideTitles(
                                      showTitles: true,
                                      margin: 2,
                                      getTitles: (v){
                                        return ''+v.round().toString();
                                      },
                                      getTextStyles: (v)=>TextStyle(
                                        color: Colors.white
                                      ),
                                      reservedSize: 10
                                    ),
                                    leftTitles: SideTitles(
                                      interval: 20,
                                      showTitles: true,
                                      margin: 10,
                                      getTitles: (v){
                                        return v.round().toString();
                                      },
                                      getTextStyles: (v)=>TextStyle(
                                        color: Colors.white
                                      ),
                                      reservedSize: 39
                                    ),
                                  ),
                                  minX: 1,
                                  maxX: _progress.length/1,
                                  minY: 0,
                                  maxY: maxWaistValue(),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: false,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine: (value){
                                      return FlLine(color: Colors.red,strokeWidth: 1);
                                    },
                                    getDrawingVerticalLine: (value){
                                      return FlLine(color: Colors.yellow,strokeWidth: 1);
                                    }
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                    //border: Border.all(color: Colors.blue,width: 5)
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      isCurved: true,
                                      barWidth: 5,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        colors: <Color>[
                                          Color.fromRGBO(251, 219, 20, 1),
                                          Color.fromRGBO(251, 219, 20, 1)
                                        ].map((color) => color.withOpacity(0.3) ).toList()
                                      ),
                                      colors: <Color>[
                                        Color.fromRGBO(251, 219, 20, 1)
                                      ],
                                    spots: _waistSpots
                                  )
                                  
                                  ]

                                )
                              ),
                              ),


                              Container(height: 50,)
                                     





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
