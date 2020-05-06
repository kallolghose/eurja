import 'package:flutter/material.dart';

class MyButton extends StatefulWidget{
  MyButton({Key key, this.buttonText}) : super(key:key);
  final String buttonText;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>{
  _MyButtonState(){
    this.buttonText;
  }
  String buttonText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}