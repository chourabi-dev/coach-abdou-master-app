import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_abdou/componenets/BlocRepetions.dart';
import 'package:coach_abdou/services/api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciceDetailsPage extends StatefulWidget {
  ExerciceDetailsPage({Key key, this.title, this.exercice}) : super(key: key);
  final String title;
  final dynamic exercice;

  @override
  _ExerciceDetailsPageState createState() => _ExerciceDetailsPageState();
}

class _ExerciceDetailsPageState extends State<ExerciceDetailsPage> {
  dynamic _exercice;

  Api api = new Api();

  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: 'l0U7SxXHkPY',
      flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          
      ),
      
  );



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _exercice = widget.exercice;

    print(_exercice);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;


    return Scaffold(   
      backgroundColor: Colors.blueGrey.shade900,   
      body: Container(
        padding: EdgeInsets.only(left:15,right:15),
        child: ListView(
        children: [

          Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              _exercice['title'],
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(251, 219, 20, 1)),
            ),
          ),
          Divider(),
          
           Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Instructions",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(251, 219, 20, 1)),
            ),
          ),

          Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              _exercice['description'],
              style: TextStyle(
                  fontSize: 17,),
            ),
          ),

          

           Container(
             
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Demo video",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(251, 219, 20, 1)),
            ),
          ),

                    Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.play();
                    _controller.addListener(() {
                      
                    });
                },
            ),

          ),
          

           Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Reps(s)",
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(251, 219, 20, 1)),
            ),
          ),

           Container(
            width: width - 30,
            margin: EdgeInsets.only(top: 15),
            child: Column(children: 

             _exercice['sets'].map<Widget>((item) {
               return BlocRepetitions(c: context,reps: int.parse(item['reps']),pause: int.parse(item['pause']), );
             }).toList()

              
            )
          ),

















        ],
      ),
      )
    );
  }
}
