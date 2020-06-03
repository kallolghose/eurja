import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';

CountryCodeResponse countryCodeFromJson(String str){
  final jsonData = json.decode(str);
  return CountryCodeResponse.fromJson(jsonData);
}

class CountryCodeResponse extends APIResponse{
  List<CountryCodeData> data;

  CountryCodeResponse({bool status, String message, dynamic error, this.data}) : super(status:status, message:message, error:error);

  factory CountryCodeResponse.fromJson(Map<String, dynamic> json) => new CountryCodeResponse(
    status: json['status'],
    message: json['message'],
    error: json['error'] !=null ? (json['error'] as List<dynamic>).cast<String>() : null,
    data: json['data'] !=null ? (json['data'] as List<dynamic>)
        .map((e) {
          return CountryCodeData(
            countryCode: e['countryCode'],
            countryName: e['countryName'],
            countryCodeString: e['countryCodeString'],
            countryImage: e['countryImage'],
            displayText: e['displayText'],
            phoneNumberLength: e['phoneNumberLength']
          );
    }).toList(): null
  );
}

class CountryCodeData {

  CountryCodeData({this.countryCode, this.countryCodeString, this.countryName, this.countryImage, this.displayText, this.phoneNumberLength});

  int countryCode;
  String countryCodeString;
  String countryName;
  String countryImage;
  String displayText;
  int phoneNumberLength;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryCodeData &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode &&
          countryCodeString == other.countryCodeString &&
          countryName == other.countryName &&
          phoneNumberLength == other.phoneNumberLength;

  @override
  int get hashCode =>
      countryCode.hashCode ^
      countryCodeString.hashCode ^
      countryName.hashCode ^
      phoneNumberLength.hashCode;
}