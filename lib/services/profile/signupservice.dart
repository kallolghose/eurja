import 'package:http/http.dart' as http;
import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:eurja/models/profile/signupmodels.dart';

const url = app_constants.API_URL + "/users/signup";

abstract class SignUpCallBack{
  void onSignUpSuccess(SignUpResponse signUpResponse);
  void onSignUpFailure(String message);
}

abstract class OTPCallBack{
  void onOTPSuccess(OTPResponse otpResponse);
  void onOTPFailure(String message);
}

class OTPApi{
  OTPCallBack _otpCallBack;
  OTPApi(this._otpCallBack);

  validateOTP(OTPRequest otpRequest){
    callOTPApi(otpRequest).then((value) => {
      _otpCallBack.onOTPSuccess(value)
    }).catchError((error, stackTrace){
      _otpCallBack.onOTPFailure(error);
    });
  }

  Future<OTPResponse> callOTPApi(OTPRequest otpRequest) async {
    final response = await http.post('$url' + '/validateotp',
        headers: {
          'content-type': 'application/json'
        },
        body: otpToJson(otpRequest)
    );
    OTPResponse otpResponse = otpFromJson(response.body);
    if(response.statusCode == 200) {
      if(otpResponse.status != false)
        return otpResponse;
      else{
        throw (otpResponse.error[0]);
      }
    }
    else if(response.statusCode == 404)
      throw (otpResponse.message);
    else if(response.statusCode == 409)
      throw (otpResponse.error[0]);
    else
      throw ("Some error occured !!");
  }

}

class SignUpApi{
  SignUpCallBack _signUpCallBack;
  SignUpApi(this._signUpCallBack);

  performSignUp(SignUpRequest signUpRequest){
    signUp(signUpRequest).then((value) => {
      _signUpCallBack.onSignUpSuccess(value)
    }).catchError((error, stackTrace){
      print(stackTrace);
      _signUpCallBack.onSignUpFailure(error.toString());
    });
  }

  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    final response = await http.post('$url' + '/create',
        headers: {
          'content-type': 'application/json'
        },
        body: toJson(signUpRequest)
    );
    SignUpResponse signUpResponse = fromJson(response.body);
    if(response.statusCode == 200)
      return signUpResponse;
    else if(response.statusCode == 404)
      throw (signUpResponse.message);
    else if(response.statusCode == 409)
      throw (signUpResponse.error[0]);
    else
      throw ("Some error occured !!");
  }
}