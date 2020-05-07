import 'package:flutter/material.dart';

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
