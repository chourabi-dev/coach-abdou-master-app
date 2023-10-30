import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Api {

  String url ="http://coach-abdou.com";
  //String url ="http://192.168.1.11/coachabdou";
  Map<String, String> headers = {'gympro-token':  'yytgsfrahjuiplns2sutags4poshn1'};


  Api();


              
  Future<Response> signupUser(String fullname,String phone,String gender,String adress,String email,String password
  ,String age,String height,String  weight,String waist,String since,String time,String diet,String food,String health,String goal,String more 
  
  ) async {
    String endPoint = this.url+"/API/mobile/signUpUser/index.php";
  
    String json = '{"fullname": "'+fullname+'","phone": "'+phone+'","gender": "'+gender+'","adress": "'+adress+'","email": "'+email+'","password": "'+password+'",' ;
    json+='"age": "'+age+'","height": "'+height+'","weight": "'+weight+'","waist": "'+waist+'","since": "'+since+'","time": "'+time+'","diet": "'+diet+'","food": "'+food+'","health": "'+health+'","goal": "'+goal+'","more": "'+more+'"  } ';
    return await post(endPoint, headers: headers, body: json);


  }
  


  Future<Response> getUserInfo(String code) async {
    String endPoint = this.url+"/API/mobile/getUserInfo/index.php";
  
  String json = '{"code": "'+code+'"}';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

  Future<Response> userAuth(String code, String password) async {
    String endPoint = this.url+"/API/mobile/userAuth/index.php";
 
  
  String json = '{"code": "'+code+'" , "password": "'+password+'" }';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

  Future<Response> signInUser(String email, String password) async {
    String endPoint = this.url+"/API/mobile/SignInUser/index.php";


  
  String json = '{"email": "'+email+'" , "password": "'+password+'" }';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}



Future<Response> updateUserPassword(String code, String newPassword) async {
  String endPoint = this.url+"/API/mobile/updateUserPassword/index.php";


  // make POST request
  return await post(endPoint);


}




Future<Response> updateUserData(String code, String email,String phone) async {
  String endPoint = this.url+"/API/mobile/updateUserData/index.php";
  
  String json = '{"code": "'+code+'" , "email": "'+email+'" , "phone": "'+phone+'" }';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

Future<Response> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 
 

  String endPoint = this.url+"/API/mobile/getUserData/index.php";
  
  String json = '{"token": "'+token+'" }';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}


Future<Response> updateNotificationsView() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 
  print(token);

  String endPoint = this.url+"/API/mobile/updateNotificationsView/index.php";
  
  String json = '{"token": "'+token+'" }';

  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

Future<Response> newReclamation(String title,String descripton) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 


  String endPoint = this.url+"/API/mobile/newReclamation/index.php";
  
  String json = '{"token": "'+token+'", "title": "'+title+'", "description": "'+descripton+'" }';
    print("the token is"+token);
  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

Future<Response> reportBug(String descripton) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 


  String endPoint = this.url+"/API/mobile/reportBug/index.php";
  
  String json = '{"token": "'+token+'", "description": "'+descripton+'" }';
  // make POST request
  return await post(endPoint, headers: headers, body: json);


}




Future<Response> saveMemberToken(String fcm) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 


  String endPoint = this.url+"/API/mobile/saveFCMMember/index.php";
  
  String json = '{"token": "'+token+'", "fcm": "'+fcm+'" }';
  // make POST request
  return await post(endPoint, headers: headers, body: json);


}

Future<Response> uploadProfilePicture( File mainAvatar ) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 



  String endPoint = this.url+"/API/mobile/updateProfilePicture/index.php";


  String fileName = mainAvatar.path.split('/').last;
  String json = '{"name": "'+fileName+'","image": "'+base64Encode(mainAvatar.readAsBytesSync())+'","token": "'+token+'"}';


  return await post(endPoint, headers: headers, body: json );

}

Future<Response> uploadWeeklyImages( File side,File front, File back ) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 


  String endPoint = this.url+"/API/mobile/uploadWeeklyPictures/index.php";
  String json = '{"side": "'+base64Encode(side.readAsBytesSync())+'","front": "'+base64Encode(front.readAsBytesSync())+'","back": "'+base64Encode(back.readAsBytesSync())+'","token": "'+token+'"}';


  return await post(endPoint, headers: headers, body: json );

}

Future<Response> uploadWeeklyDataAndImages( File side,File front, File back, String weight , String waist, String feedback ) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token  = prefs.getString('token'); 


  String endPoint = this.url+"/API/mobile/uploadWeeklyDataAndPictures/index.php";
  String json = '{"feedback": "'+feedback+'","waist": "'+waist+'","weight": "'+weight+'","side": "'+base64Encode(side.readAsBytesSync())+'","front": "'+base64Encode(front.readAsBytesSync())+'","back": "'+base64Encode(back.readAsBytesSync())+'","token": "'+token+'"}';


  return await post(endPoint, headers: headers, body: json );

}















}