import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';

ChargerResponse chargerFromJson(String str){
  final jsonData = json.decode(str);
  return ChargerResponse.fromJson(jsonData);
}

class ChargerResponse extends APIResponse{

  ChargerResponse({bool status, String message, List<String> error, this.data}) : super(status:status,
  message:message, error:error);

  List<ChargerData> data;

  factory ChargerResponse.fromJson(Map<String, dynamic> json) => ChargerResponse(
    status: json["status"],
    message: json["message"],
    error: json["error"]!=null ? (json["error"] as List<dynamic>).cast<String>() : null,
    data: json["data"] != null ? (json["data"] as List<dynamic>)
        .map((e) {
          return ChargerData(
              id: e['id'],
              chargerUdid: e['chargerUdid'],
              stationUdid: e['stationUdid'],
              serialnumber: e['serialnumber'],
              qrData: e['qrData'],
              type: e['type'],
              chargerName: e['chargerName'],
              latitude: e['latitude'],
              longitude: e['longitude'],
              vendorname: e['vendorname'],
              firmwareversion: e['firmwareversion'],
              lastonline: e['lastonline'],
              status: e['status'],
              statusVal: e['statusVal'],
              power: e['power'],
              current: e['current'],
              cable: e['cable'],
              chargerPricingDetails: e['chargerPricingDetails']!=null ? ChargerPricingDetails(
                id: e['chargerPricingDetails']['id'],
                chargerUdid: e['chargerPricingDetails']['chargerUdid'],
                pricingUdid: e['chargerPricingDetails']['pricingUdid'],
                ratePerHr: e['chargerPricingDetails']['ratePerHr'],
                ratePerMin: e['chargerPricingDetails']['ratePerMin'],
              ) : null
          );
        }).toList():null,
  );

}

class ChargerData{

  int id;
  String chargerUdid;
  String stationUdid;
  String serialnumber;
  String qrData;
  String type;
  String chargerName;
  double latitude;
  double longitude;
  String vendorname;
  String firmwareversion;
  DateTime lastonline;
  String status;
  String statusVal;
  double power;
  String current;
  bool cable;
  ChargerPricingDetails chargerPricingDetails;

  ChargerData({this.id, this.chargerUdid, this.stationUdid, this.serialnumber, this.qrData, this.type,
    this.chargerName, this.latitude, this.longitude, this.vendorname, this.firmwareversion, this.lastonline, this.status,
    this.statusVal, this.power, this.current, this.cable, this.chargerPricingDetails});

}

class ChargerPricingDetails{

  int id;
  String chargerUdid;
  String pricingUdid;
  double ratePerHr;
  double ratePerMin;

  ChargerPricingDetails({this.id, this.chargerUdid, this.pricingUdid, this.ratePerHr, this.ratePerMin});

}