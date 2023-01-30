import 'package:coach_abdou/pages/CheckerAuthPage.dart';
import 'package:flutter/material.dart';


void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coach Abdou',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'AgencyFB',
        
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
        accentColor: Colors.blueGrey.shade900,
        primarySwatch: Colors.yellow,
        
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blueGrey.shade900,
          selectedItemColor: Colors.white,
           type: BottomNavigationBarType.fixed,
           unselectedItemColor: Color.fromRGBO(251, 219, 20, 1)
           
            )
        

        


      ),
      home: CheckerAuthPage(title: ''),
    );
  }
}

