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

class SignUpRequest{

  String emailId;
  String isdCode;
  int phoneNo;
  String password;

  SignUpRequest({this.emailId, this.isdCode, this.phoneNo, this.password});

  Map<String, dynamic> toJson() => {
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
    error: (json['error'] as List<dynamic>).cast<String>(),
    data : SignUpData(
      userId: json["data"]["userId"],
      emailId: json["data"]["emailId"],
      phoneNo: json["data"]["phoneNo"],
      isdCode: json["data"]["isdCode"],
      status: json["data"]["status"],
      active: json["data"]["active"]
    )
  );
}

class SignUpData{

  String userId;
  String emailId;
  int phoneNo;
  String isdCode;
  String status;
  String active;

  SignUpData({this.userId, this.emailId, this.phoneNo, this.isdCode, this.status, this.active});

}