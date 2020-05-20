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
  DateTime pickedDateTime;
  TimeOfDay timeOfDay;
  TextEditingController fullNameController, phoneNumberController, emailController,
    dateController, timeController;

  @override
  void initState() {
    super.initState();
    type = "Type 2";
    power = "3.0 kW AC";
    address = "Sector 47, NOIDA, UP";
    available = "Available";
    availableTextColor = Color.fromRGBO(20, 140, 32, 1.0);
    pickedDateTime = DateTime.now();
    timeOfDay = TimeOfDay.now();

    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    dateController = TextEditingController(text: pickedDateTime.toString());
    timeController = TextEditingController(text: timeOfDay.toString());

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
                              controller: fullNameController,
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
                              controller: phoneNumberController,
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
                              controller: emailController,
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
                                    controller: dateController,
                                    focusNode: FocusNode(),
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                        isDense: true
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickupDate,
                                  child: Icon(Icons.date_range,
                                    color: Colors.blue,
                                  ),
                                ),

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
                                    controller: timeController,
                                    focusNode: FocusNode(),
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                      isDense: true
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickUpTime,
                                  child: Icon(Icons.access_time,
                                    color: Colors.blue,
                                  ),
                                ),
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

  _pickupDate() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDateTime,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year+5),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if(date!=null){

    }
  }

  _pickUpTime() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if(timeOfDay != null){

    }
  }
}
