import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eurja/constants/app_constants.dart' as constants;

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
    return formatted;
  }

  String getFormattedTime(BuildContext context, TimeOfDay time){

    return time.format(context);
  }

}