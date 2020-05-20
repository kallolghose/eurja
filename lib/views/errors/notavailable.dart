import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';

class SomethingWentWrongPage extends StatefulWidget{

  SomethingWentWrongPage({Key key}) : super(key:key);

  _SomethingWentWrongPage createState() => _SomethingWentWrongPage();

}

class _SomethingWentWrongPage extends State<SomethingWentWrongPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(myTitle: "Not Available", context: context,),
      body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/oops_png.png",
                    width: 200,
                    height: 200,
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text(
                "Something went wrong !!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              )

            ],
          )
      ),
    );
  }
}