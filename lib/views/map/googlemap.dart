import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eurja/services/inventory/stationservice.dart';
import 'package:eurja/models/inventory/stationmodel.dart';
import 'package:eurja/utilities/mycomponents.dart';
import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:eurja/services/navigation_service.dart';
import 'package:eurja/locator.dart';
import 'package:eurja/constants/routes_path.dart' as routes;

class MapSample extends StatefulWidget {
  @override
  MapSampleState createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> implements StationCallBack {

  NavigationService _navigationService = locator<NavigationService>();

  Completer<GoogleMapController> _controller = Completer();

  static LatLng _initialPosition = LatLng(28.53556133580664, 77.391049655962);
  static  LatLng _lastMapPosition = _initialPosition;
  BitmapDescriptor pinLocationIconActive, pinLocationIconInActive;
  Set<Marker> _markers = {};
  AppUtilities appUtilities = new AppUtilities();
  StationApi stationApi;

  @override
  void onStationSuccess(StationResponse stationResponse) {
   stationResponse.data.map((e) {
     return Marker(
       markerId: MarkerId(e.stationUdid),
       position: LatLng(e.latitude, e.longitude),
       icon: pinLocationIconActive,
       onTap: (){
         showStationChargerDetails(e);
       }
     );
   }).forEach((element) {
     _markers.add(element);
   });
   print(_markers);
   setState(() {
   });
  }

  @override
  void onStationFailure(String message) {
    appUtilities.showSnackBar(context, message, app_constants.ERROR);
  }

  @override
  void initState(){
    super.initState();
    _getUserLocation();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration( size: Size(48,48)),
        'assets/images/icon_active.png').then((onValue) {
        pinLocationIconActive = onValue;
    });
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration( size: Size(48,48)),
        'assets/images/icon_red.png').then((onValue) {
        pinLocationIconInActive = onValue;
    });
    stationApi = StationApi(this);
  }

  void showStationChargerDetails(StationData stationData){

    List<String> distinctChargers = stationData.chargers.map((e) => e.type).toSet().toList();
    List<Widget> chargerTypesIcons = List();
    distinctChargers.forEach((element) {
      Widget image;
      if(element == "type2"){
        image = Image.asset("assets/images/ic_type2.png",);
      }
      if(element == "ccs2"){
        image = Image.asset("assets/images/ic_ccs2.png",);
      }
      if(element == "chademo"){
        image = Image.asset("assets/images/ic_chademo.png",);
      }

      Container container = Container(
        width: 50,
        height: 50,
        child: image,
      );

      Column col = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          container,
          Text(element)
        ],
      );
      chargerTypesIcons.add(SizedBox(
        width: 10,
      ));
      chargerTypesIcons.add(col);
    });

    Row row1 = Row(
      mainAxisSize: MainAxisSize.max,
      children: chargerTypesIcons,
    );

    Row row2 = Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.all(5.0),
            child: Image.asset("assets/images/ic_address.png"),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                stationData.stationName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                stationData.address + ", " + stationData.city + ", " + stationData.state,
                style: TextStyle(
                    fontSize: 12,
                )
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.directions,
                color: Colors.blue,
              ),
              Text(
                "6500 KM"
              )
            ],
          ),
        )
      ],
    );

    ListView listView = ListView.separated(
      itemCount: stationData.chargers.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index){
        return Container(
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(width: 15,),
              Container(
                width: 15,
                height: 15,
                  decoration: new BoxDecoration(
                    color: stationData.chargers[index].status == "Y" ? Color.fromRGBO(20, 140, 32, 1.0) : Colors.red,
                    shape: BoxShape.circle,
                  )
              ),
              SizedBox(width: 10,),
              Container(
                width: 40,
                height: 40,
                child: Image.asset("assets/images/ic_" + stationData.chargers[index].type + ".png"),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    stationData.chargers[index].type,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    stationData.chargers[index].power.toString() + " kW " +
                    stationData.chargers[index].current,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Rate (Rs.)",
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    stationData.chargers[index].price.ratePerHr.toString() + "/hr, " +
                    stationData.chargers[index].price.ratePerMin.toString() + "/min",
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              SizedBox(width: 10,),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    _navigationService.navigateToWithData(routes.CreateBookingsRoute, {"stationData" : stationData, "index" : index});
                  },
                  child :Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Book Now",
                            style: TextStyle(
                                color: Colors.blue
                            ),
                          ),
                          Icon(Icons.arrow_right, color: Colors.blue,)
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        );
      }) ;

    //60, 220 for 1
    //130, 280 for 2

    double heightListView = 60, heightPopUp = 220;
    if(stationData.chargers.length >= 2){
      heightListView = 130;
      heightPopUp = 280;
    }

    Container row3 = Container(
      height: heightListView,
      child: listView,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
      builder: (BuildContext context){
        return Container(
          height: heightPopUp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            color: Color(0xffE0EDF7),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              row1,
              SizedBox(height: 5,),
              row2,
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.only(top:5, left:20, right:20),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black26),
                  height: 2,
                ),
              ),
              SizedBox(height: 5,),
              row3
            ],
          ),
        );
      }
    );
  }

  void _getUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }


  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 14.4746
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          stationApi.getAllStations();
        },
        markers: _markers,
      ),
    );
  }

}