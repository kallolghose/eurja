import 'dart:convert';
import 'package:eurja/models/apiresponse.dart';
import 'package:eurja/utilities/mycomponents.dart';

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
    data: json["data"] !=null ?  LoginData.fromJson(json["data"]) :null,
  );
}

class LoginData{
  String firstName;
  String lastName;
  String userId;
  String emailId;
  String isdCode;
  int phoneNo;
  UserAdditionalInfo userAdditionalInfo;
  Token token;

  LoginData({this.firstName, this.lastName, this.userId, this.emailId, this.isdCode, this.phoneNo, this.userAdditionalInfo, this.token});

  Map<String, dynamic> toJson() => {
    "emailId":emailId,
    "isdCode":isdCode,
    "phoneNo":phoneNo,
    "firstName":firstName,
    "lastName":lastName,
    "userId":userId
  };

  factory LoginData.fromJson(Map<String, dynamic> json) => new LoginData(
    emailId: json['emailId'],
    isdCode: json["isdCode"],
    phoneNo: json['phoneNo'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    userId: json['userid'],
    userAdditionalInfo: json['userAdditionalInfo']!=null ? UserAdditionalInfo.fromJson(json['userAdditionalInfo']) : null,
    token: json['token']!=null ? Token.fromJson(json['token']) : null
  );

}

class Token{

  bool status;
  String authentication;
  String token;

  Token({this.status, this.authentication, this.token});

  Map<String, dynamic> toJson() => {
    "status":status,
    "authentication":authentication,
    "token":token
  };

  factory Token.fromJson(Map<String, dynamic> json) => new Token(
    status: json['status'],
    authentication: json['authentication'],
    token: json['token']
  );
}

class UserAdditionalInfo {
  int id;
  String userId;
  String emailId;
  String isdCode;
  String active;
  String addressId;
  DateTime dateOfBirth;
  int age;
  String gender;
  String firstName;
  String lastName;
  int phoneNo;
  Address address;

  UserAdditionalInfo({this.id, this.userId, this.emailId, this.isdCode, this.active, this.addressId, this.dateOfBirth,
      this.age, this.gender, this.firstName, this.lastName, this.phoneNo, this.address});

  Map<String, dynamic> toJson() => {
    "id" : id,
    "userId" : userId,
    "emailId" : emailId,
    "isdCode" : isdCode,
    "active"  : active,
    "addressId" : addressId,
    "dateOfBirth" : new AppUtilities().getFormattedDate(dateOfBirth, "yyyy-MM-dd"),
    "age" : age,
    "gender" : gender,
    "firstName" : firstName,
    "lastName" : lastName,
    "phoneNo": phoneNo
  };

  factory UserAdditionalInfo.fromJson(Map<String, dynamic> json) => new UserAdditionalInfo(
    id: json["id"],
    userId: json["userId"],
    emailId: json["emailId"],
    isdCode: json["isdCode"],
    active: json["active"],
    addressId: json["addressId"],
    dateOfBirth: new AppUtilities().getDateTime(json["dateOfBirth"], "yyyy-MM-dd"),
    age: json["age"],
    gender: json["gender"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNo: json["phoneNo"],
    address: json["address"]!=null ? Address.fromJson(json["address"]) : null
  );

}

class Address {
  int id;
  String addressId;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  int pinCode;
  String country;

  Address({this.id, this.addressId, this.addressLine1, this.addressLine2, this.city, this.state, this.pinCode, this.country});

  Map<String, dynamic> toJson() => {
    "id":id,
    "addressId":addressId,
    "addressLine1":addressLine1,
    "addressLine2":addressLine2,
    "city":city,
    "state":state,
    "pinCode":pinCode,
    "country":country,
  };

  factory Address.fromJson(Map<String, dynamic> json) => new Address(
    id:json["id"],
    addressId:json["addressId"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    state: json["state"],
    pinCode: json["pinCode"],
    country: json["country"]
  );
}