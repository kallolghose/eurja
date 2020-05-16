import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';
import 'package:eurja/models/inventory/chargermodel.dart';


StationResponse stationFromJson(String str){
  final jsonData = json.decode(str);
  return StationResponse.fromJson(jsonData);
}

class StationResponse extends APIResponse{

  StationResponse({bool status, String message, List<String> error, this.data}) : super(status:status,
  message:message, error:error);

  List<StationData> data;

  factory StationResponse.fromJson(Map<String, dynamic> json) => StationResponse(
    status: json['status'],
    message: json['message'],
    error: json['error'] != null ? (json["error"] as List<dynamic>).cast<String>() : null,
    data: json['data']!=null?
        (json['data'] as List<dynamic>).map((e)  {
          return StationData(
            id: e['id'],
            stationUdid: e['stationUdid'],
            stationName: e['stationName'],
            latitude: e['latitude'],
            longitude: e['longitude'],
            address: e['address'],
            state: e['state'],
            city: e['city'],
            pincode: e['pincode'],
            ownerId: e['ownerId'],
            countryCode: e['countryCode'],
            lastonline: e['lastonline'],
            chargers: (e['chargers'] as List<dynamic>).map((k) {
              return ChargerData(
                  id: k['id'],
                  chargerUdid: k['chargerUdid'],
                  stationUdid: k['stationUdid'],
                  serialnumber: k['serialnumber'],
                  qrData: k['qrData'],
                  type: k['type'],
                  chargerName: k['chargerName'],
                  latitude: k['latitude'],
                  longitude: k['longitude'],
                  vendorname: k['vendorname'],
                  firmwareversion: k['firmwareversion'],
                  lastonline: k['lastonline'],
                  status: k['status'],
                  statusVal: k['statusVal'],
                  power: k['power'],
                  current: k['current'],
                  cable: k['cable'],
                  chargerPricingDetails: k['chargerPricingDetails']!=null ? ChargerPricingDetails(
                    id: k['chargerPricingDetails']['id'],
                    chargerUdid: k['chargerPricingDetails']['chargerUdid'],
                    pricingUdid: k['chargerPricingDetails']['pricingUdid'],
                    ratePerHr: k['chargerPricingDetails']['ratePerHr'],
                    ratePerMin: k['chargerPricingDetails']['ratePerMin'],
                  ) : null
              );
            }).toList()
          );
        }).toList()
        : null,
  );

}

class StationData {

  int id;
  String stationUdid;
  String stationName;
  double latitude;
  double longitude;
  String address;
  String state;
  String city;
  int pincode;
  int ownerId;
  int countryCode;
  String lastonline;
  List<ChargerData> chargers;

  StationData({this.id, this.stationUdid, this.stationName, this.latitude, this.longitude,
  this.address, this.state, this.city, this.pincode,  this.ownerId, this.countryCode, this.lastonline,
  this.chargers});


}
