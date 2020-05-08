import 'dart:convert';

LoginResponse postFromJson(String str) {
  final jsonData = json.decode(str);
  return LoginResponse.fromJson(jsonData);
}

String postToJson(LoginRequest data) {
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

class LoginResponse{

  String firstName;
  String lastName;
  String userId;
  String emailId;
  String isdCode;
  int phoneNo;
  Token token;

  LoginResponse({this.firstName, this.lastName, this.userId, this.emailId, this.isdCode, this.phoneNo, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => new LoginResponse(
    firstName: json["firstName"],
    lastName: json["lastName"],
    userId: json["userid"],
    emailId: json["emailId"],
    isdCode: json["isdCode"],
    phoneNo: json["phoneNo"],
    token: Token(
      status: json["token"]["status"],
      authentication: json["token"]["authentication"],
      token: json["token"]["token"],
    )
  );
}

class Token{

  bool status;
  String authentication;
  String token;

  Token({this.status, this.authentication, this.token});

}
