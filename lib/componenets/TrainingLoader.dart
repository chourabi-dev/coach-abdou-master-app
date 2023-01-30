import 'package:coach_abdou/pages/UpdateWeeklyData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingLoader extends StatelessWidget {
  final double screenWidth;


  const TrainingLoader({Key key, this.screenWidth}) : super(key: key);

/*
  getProgressValue(){
    DateTime today = new DateTime.now();
    String startDateString = workout['startDate'];

    int year = int.parse(startDateString.substring(0, 4));
    int month = int.parse(startDateString.substring(5, 7));
    int days = int.parse(startDateString.substring(8, 10));


    DateTime startDate = new DateTime( year , month , days );

    int diffrence = today.millisecondsSinceEpoch - startDate.millisecondsSinceEpoch;

    double daysDfirrence = ((((diffrence / 1000) / 60 ) / 60 ) / 24 );

    print(daysDfirrence.round() % 7);

    return ( (daysDfirrence % 7) / 7 );


  }
  



  Color getProgressColor(){
    if( getProgressValue() >= 0.8 ){
      return Colors.redAccent;
    }

    return Colors.green;
  }


  String getStatusText(){
    if( getProgressValue() >= 0.8 ){
      return 'READY TO UPDATE';
    }

    return 'KEEP IT UP';
  }*/




  @override
  Widget build(BuildContext context) {

    //getProgressValue();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
      onTap: (){
        // go to update workout data page
        
                  Navigator.push(
                    context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          UpdateWeeklyData()));
        




      },
      child: Container(
        
      decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/progress.jpg"),
                                                  fit: BoxFit.cover,
                                                  
                                                  
                                                  )),
      margin: EdgeInsets.only(left:15,right: 15,top:30),
      height: 150,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 15,left: 15),
            child: Text("CHECK IN ",style: TextStyle( fontSize: 60, fontWeight: FontWeight.w600 ),),
          
          ),

          /*Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Text("please show us your progress",style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold ),),
          
          ),*/
          

        ],
      )
    )
    ),
    );
  }
}
