import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedias extends StatelessWidget {
  const SocialMedias({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
        IconButton(
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: FaIcon(FontAwesomeIcons.facebook,color: Colors.amberAccent,), 
          onPressed: () { launch('https://m.facebook.com/144138919523869'); }
        ),
        IconButton(
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: FaIcon(FontAwesomeIcons.youtube,color: Colors.amberAccent,), 
          onPressed: () { launch('https://youtube.com/channel/UCxBObq_F0u0BuA3PCWJKVVA'); }
        ),
        IconButton(
          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: FaIcon(FontAwesomeIcons.instagram,color: Colors.amberAccent,), 
          onPressed: () { launch("https://www.instagram.com/coach_abdou_/"); }
        ),
        
     

      ],),
    );
  }
}