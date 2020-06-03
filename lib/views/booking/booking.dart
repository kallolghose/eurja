import 'package:flutter/material.dart';
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/models/inventory/stationmodel.dart';
import 'package:eurja/models/inventory/chargermodel.dart';

class BookingPage extends StatefulWidget{
  BookingPage({Key key, this.chargerDetails}) : super(key:key);

  dynamic chargerDetails;

  @override
  _BookingPage createState() => _BookingPage(chargerDetails);
}

class _BookingPage extends State<BookingPage>{

  _BookingPage(this.chargerDetails);

  dynamic chargerDetails;

  String type, power, address, available;
  double ratePerHr, ratePerMin;
  Color availableTextColor;
  DateTime pickedDateTime;
  TimeOfDay timeOfDay;
  TextEditingController fullNameController, phoneNumberController, emailController,
      dateController, timeController;
  AppUtilities _appUtilities = new AppUtilities();
  GlobalKey<FormState> bookingKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    pickedDateTime = DateTime.now();
    timeOfDay = TimeOfDay.now();

    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    dateController = TextEditingController(text: _appUtilities.getFormattedDate(pickedDateTime, "yyyy-MM-dd"));
    timeController = TextEditingController(text: _appUtilities.getFormattedTime(context, timeOfDay));

    StationData stationData = chargerDetails['stationData'];
    int index = chargerDetails['index'];
    ChargerData chargerData = stationData?.chargers[index];

    type = chargerData?.type;
    power = chargerData?.power.toString() + " kW " + chargerData?.current?.toUpperCase();
    address = stationData?.address + ", " + stationData?.city + ", " + stationData?.state;
    available = (chargerData?.status == "Y") ? "Available" : "Not Available";
    availableTextColor = (chargerData?.status == "Y") ? Color.fromRGBO(20, 140, 32, 1.0) : Colors.red;
    ratePerHr = chargerData!=null && chargerData.price!=null ? chargerData.price.ratePerHr : 0.0;
    ratePerMin = chargerData!=null && chargerData.price!=null ? chargerData.price.ratePerMin : 0.0;

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
                          SizedBox(height: 3,),
                          Text(power),
                          SizedBox(height: 3,),
                          Text(address),
                          SizedBox(height: 3,),
                          Text("Rs " + ratePerHr.toString() + "/hr, Rs" + ratePerMin.toString() + "/min"),
                          SizedBox(height: 3,),
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
                child: Form(
                  key: bookingKey,
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
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                    return "Full Name Required";
                                  return null;
                                },
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
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                    return "Phone Number Required";
                                  return null;
                                },
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
                                validator: (value) {
                                  if(value == null || value.isEmpty)
                                    return "Email Required";
                                  return null;
                                },
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
                                      enabled: false,
                                      controller: dateController,
                                      focusNode: FocusNode(),
                                      enableInteractiveSelection: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                      ),
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
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
                            SizedBox(width: 5,),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Time : "),
                                  Expanded(
                                    child: TextFormField(
                                      enabled: false,
                                      controller: timeController,
                                      focusNode: FocusNode(),
                                      enableInteractiveSelection: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                      ),
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
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
      dateController.text = _appUtilities.getFormattedDate(date, "yyyy-MM-dd");
    }
  }

  _pickUpTime() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    TimeOfDay timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if(timeOfDay != null){
      timeController.text = _appUtilities.getFormattedTime(context, timeOfDay);
    }
  }
}
