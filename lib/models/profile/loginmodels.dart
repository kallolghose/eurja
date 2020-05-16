import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';

LoginResponse fromJson(String str) {
  final jsonData = json.decode(str);
  return LoginResponse.fromJson(jsonData);
}

String toJson(LoginRequest data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LoginRequest{

  String emailId;
  String isdCode;
  int phoneNo;
  String password;

  LoginRequest({this.emailId, this.isdCode, this.phoneNo, this.password});

  Map<String, dynamic> toJson() => {
    "emailId":emailId,
    "isdCode":isdCode,
    "phoneNo":phoneNo,
    "password":password
  };
}

class LoginResponse extends APIResponse{

  LoginData data;

  LoginResponse({bool status, String message, List<String> error, this.data}) : super(status:status, message:message, error:error);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => new LoginResponse(

    status: json['status'],
    message: json['message'],
    error: json['error'] !=null ? (json['error'] as List<dynamic>).cast<String>() : null,
    data: json["data"] !=null ?  LoginData(
        firstName: json["data"]["firstName"],
        lastName: json["data"]["lastName"],
        userId: json["data"]["userid"],
        emailId: json["data"]["emailId"],
        isdCode: json["data"]["isdCode"],
        phoneNo: json["data"]["phoneNo"],
        token: Token(
          status: json["data"]["token"]["status"],
          authentication: json["data"]["token"]["authentication"],
          token: json["data"]["token"]["token"],
        )
    ):null,
  );
}

class LoginData{
  String firstName;
  String lastName;
  String userId;
  String emailId;
  String isdCode;
  int phoneNo;
  Token token;

  LoginData({this.firstName, this.lastName, this.userId, this.emailId, this.isdCode, this.phoneNo, this.token});
}

class Token{

  bool status;
  String authentication;
  String token;

  Token({this.status, this.authentication, this.token});

}
