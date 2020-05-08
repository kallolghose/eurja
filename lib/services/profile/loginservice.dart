import 'package:http/http.dart' as http;
import 'package:eurja/models/profile/loginmodels.dart' as login;
import 'package:eurja/constants/app_constants.dart' as app_constants;

const url = app_constants.API_URL + "/users/login";

abstract class LoginCallBack{
  void onLoginSuccess(login.LoginResponse loginResponse);
  void onLoginFailure(String message);
}

class LoginApi{
  LoginCallBack _callBack;
  LoginApi(this._callBack);

  performLogin(login.LoginRequest loginRequest){
    validateLogin(loginRequest).then((value) => {
      _callBack.onLoginSuccess(value)
    }).catchError((error, stackTrace) {
      _callBack.onLoginFailure(error);
    });
  }

  Future<login.LoginResponse> validateLogin(login.LoginRequest loginRequest) async {
    final response = await http.post('$url' + '/validate',
        headers: {
          'content-type': 'application/json'
        },
        body: login.toJson(loginRequest)
    );
    login.LoginResponse loginResponse = login.fromJson(response.body);
    if(response.statusCode == 200)
      return loginResponse;
    else if(response.statusCode == 404)
      throw (loginResponse.message);
    else if(response.statusCode == 401)
      throw (loginResponse.error[0]);
    else
      throw ("Some error occured !!");
  }

}
