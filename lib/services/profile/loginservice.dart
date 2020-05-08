import 'package:http/http.dart' as http;
import 'package:eurja/models/profile/loginmodels.dart' as login;
import 'package:eurja/constants/app_constants.dart' as app_constants;

const url = app_constants.API_URL + "";

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
    }).catchError((Exception error) => {
      _callBack.onLoginFailure(error.toString())
    });
  }

  Future<login.LoginResponse> validateLogin(login.LoginRequest loginRequest) async {
    final response = await http.post('$url',
        headers: {
          'Content-type': 'application/json'
        },
        body: login.postToJson(loginRequest)
    );
    if(response.statusCode == 200)
      return login.postFromJson(response.body);
    else if(response.statusCode == 404)
      throw Exception("User Not Found !!");
    else
      throw Exception("Some error occured !!");
  }

}
