import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';

SignUpResponse fromJson(String str) {
  final jsonData = json.decode(str);
  return SignUpResponse.fromJson(jsonData);
}

String toJson(SignUpRequest data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

OTPResponse otpFromJson(String str){
  final jsonData = json.decode(str);
  return OTPResponse.fromJson(jsonData);
}

String otpToJson(OTPRequest data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class SignUpRequest{

  String fullName;
  String emailId;
  String isdCode;
  int phoneNo;
  String password;

  SignUpRequest({this.fullName, this.emailId, this.isdCode, this.phoneNo, this.password});

  Map<String, dynamic> toJson() => {
    "fullName":fullName,
    "emailId":emailId,
    "isdCode":isdCode,
    "phoneNo":phoneNo,
    "password":password
  };
}

class SignUpResponse extends APIResponse {
  SignUpData data;

  SignUpResponse({bool status, String message, List<String> error, this.data}) : super(status:status, message:message, error:error);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => new SignUpResponse(
    status: json['status'],
    message: json['message'],
    error: json['error']!=null ? (json['error'] as List<dynamic>).cast<String>() : null,
    data : json["data"]!=null ? SignUpData(
      userId: json["data"]["userId"],
      emailId: json["data"]["emailId"],
      phoneNo: json["data"]["phoneNo"],
      isdCode: json["data"]["isdCode"],
      status: json["data"]["status"],
      active: json["data"]["active"],
      firstName: json["data"]["firstName"],
      lastName: json["data"]["lastName"]
    ) : null
  );
}

class SignUpData{

  String userId;
  String emailId;
  int phoneNo;
  String isdCode;
  String status;
  String active;
  String firstName;
  String lastName;

  SignUpData({this.userId, this.emailId, this.phoneNo, this.isdCode, this.status, this.active,this.firstName, this.lastName});

}


class OTPRequest{

  OTPRequest({this.isdCode, this.phoneNo, this.otp});

  String isdCode;
  int phoneNo;
  int otp;

  Map<String, dynamic> toJson() => {
    "isdCode":isdCode,
    "phoneNo":phoneNo,
    "otp":otp
  };
}

class OTPResponse extends APIResponse {

  OTPData data;
  OTPResponse({bool status, String message, List<String> error, this.data}) : super(status:status, message:message, error:error);

  factory OTPResponse.fromJson(Map<String, dynamic> json) => new OTPResponse(
    status: json['status'],
    message: json['message'],
    error: json['error']!=null ? (json['error'] as List<dynamic>).cast<String>() : null,
    data: json["data"] !=null ?  OTPData(
        userId: json["data"]["userId"],
        emailId: json["data"]["emailId"],
        isdCode: json["data"]["isdCode"],
        phoneNo: json["data"]["phoneNo"],
        message: json["data"]["message"],
        token: Token(
          status: json["data"]["token"]["status"],
          authentication: json["data"]["token"]["authentication"],
          token: json["data"]["token"]["token"],
        )
    ):null,
  );

}

class OTPData {

  String userId;
  String emailId;
  String isdCode;
  int phoneNo;
  String message;
  Token token;

  OTPData({this.userId, this.emailId, this.isdCode, this.phoneNo, this.message, this.token});
}

class Token{

  bool status;
  String authentication;
  String token;

  Token({this.status, this.authentication, this.token});

}


