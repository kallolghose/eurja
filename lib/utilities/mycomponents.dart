import 'package:eurja/models/profile/loginmodels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eurja/constants/app_constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyAppBar extends AppBar{
  MyAppBar({Key key, this.myTitle, this.context}) : super(key:key,
     centerTitle: true,
     elevation: 0.0,
     title: Text(myTitle,
         style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
     backgroundColor:Colors.transparent,
     leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue,),
          onPressed: () => Navigator.of(context).pop())
  );
  final String myTitle;
  final BuildContext context;
}

class AppUtilities{

  void showSnackBar(BuildContext context, String message, String messageType){
    var color = Colors.green;
    if(messageType == constants.ERROR){
      color = Colors.red;
    }
    final snackBar = SnackBar(
      content: Text(message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  String getFormattedDate(DateTime date, String formatStr){
    var formatter = DateFormat(formatStr);
    String formatted = formatter.format(date);
    //String formatted = date.parse(formattedString);
    return formatted;
  }

  DateTime getDateTime(String date, String formatStr){
    var formatter = DateFormat(formatStr);
    DateTime dateTime = formatter.parse(date);
    return dateTime;
  }

  String getFormattedTime(BuildContext context, TimeOfDay time){
    return time.format(context);
  }

  void saveLoginInformation(LoginResponse loginResponse) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("_loginData", json.encode(loginResponse.data.toJson()));
    prefs.setString("_userData", json.encode(loginResponse.data.userAdditionalInfo.toJson()));
    prefs.setString("_loginToken", json.encode(loginResponse.data.token.toJson()));
  }

  Future<LoginResponse> restoreLoginInformation() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _loginData = prefs.get("_loginData");
    String _loginToken = prefs.get("_loginToken");
    String _userData = prefs.get("_userData");
    if(_loginData !=null && _loginToken!=null) {
      LoginData loginData = LoginData.fromJson(json.decode(_loginData));
      Token tokenData = Token.fromJson(json.decode(_loginToken));
      UserAdditionalInfo userInfo;
      if(_userData!=null)
        userInfo = UserAdditionalInfo.fromJson(json.decode(_userData));
      loginData.token = tokenData;
      loginData.userAdditionalInfo = userInfo;
      LoginResponse loginResponse = new LoginResponse();
      loginResponse.data = loginData;
      return loginResponse;
    }
    else{
      throw("No User Logged In");
    }
  }

}