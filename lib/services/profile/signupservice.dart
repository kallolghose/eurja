import 'package:http/http.dart' as http;
import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:eurja/models/profile/signupmodels.dart';

const url = app_constants.API_URL + "/users/signup";

abstract class SignUpCallBack{
  void onSignUpSuccess(SignUpResponse signUpResponse);
  void onSignUpFailure(String message);
}

class SignUpApi{
  SignUpCallBack _signUpCallBack;
  SignUpApi(this._signUpCallBack);

  performSignUp(SignUpRequest signUpRequest){
    signUp(signUpRequest).then((value) => {
      _signUpCallBack.onSignUpSuccess(value)
    }).catchError((error, stackTrace){
      _signUpCallBack.onSignUpFailure(error);
    });
  }

  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    final response = await http.post('$url' + '/validate',
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