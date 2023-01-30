import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FluidButton extends StatelessWidget {
  final String  text;

  const FluidButton({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return(
      Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only( left: 15, right: 15,top: 15 ),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)) ,
                  gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade400,
                        Colors.purple.shade900
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                  ),
                ),
                child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),),
            )
    );
  }
  
}