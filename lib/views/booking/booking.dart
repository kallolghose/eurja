import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';

class BookingPage extends StatefulWidget{
  BookingPage({Key key}) : super(key:key);

  @override
  _BookingPage createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage>{

  String type, power, address, available;
  Color availableTextColor;

  _BookingPage(){
    type = "Type 2";
    power = "3.0 kW AC";
    address = "Sector 47, NOIDA, UP";
    available = "Available";
    availableTextColor = Color.fromRGBO(20, 140, 32, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: MyAppBar(myTitle: "New Booking", context: context,),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding : EdgeInsets.all(10),
                child : Container(
                  padding: EdgeInsets.all(5),
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.black12
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Image.asset("assets/images/ic_type2_top.png",
                        width: 130,
                        height: 130,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Text(type),
                          SizedBox(height: 8,),
                          Text(power),
                          SizedBox(height: 8,),
                          Text(address),
                          SizedBox(height: 8,),
                          Text(available,
                          style: TextStyle(color: availableTextColor, fontWeight: FontWeight.bold),),
                        ],
                      )
                    ],
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Booking Created For")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.supervised_user_circle, color: Colors.blue,),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Full Name",
                                  isDense: true
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.phone, color: Colors.blue),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  isDense: true
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.mail_outline,
                              color: Colors.blue
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  isDense: true
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("Date : "),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        isDense: true
                                    ),
                                  ),
                                ),
                                Icon(Icons.date_range,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text("Time : "),
                                Expanded(
                                  child: TextFormField(

                                    decoration: InputDecoration(
                                      isDense: true
                                    ),
                                  ),
                                ),
                                Icon(Icons.access_time,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: MaterialButton(
                        onPressed: (){},
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text("Create Booking"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)
                        )
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _displayCalenderPopUp(){
    FocusScope.of(context).requestFocus(new FocusNode());

  }
}

class CalenderDialog extends StatefulWidget{
  CalenderDialog({Key key}) : super(key:key);

  _CalenderDialog createState() => _CalenderDialog();
}

class _CalenderDialog extends State<CalenderDialog>{

  @override
  Widget build(BuildContext context) {

  }

}