import 'package:http/http.dart' as http;
import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:eurja/models/profile/utilitiesmodel.dart';

const url = app_constants.API_URL + "/users/utilities";

abstract class UtilitiesCallBack{
  void onCountryCodeSuccess(CountryCodeResponse countryCodeResponse);
  void onCountryCodeFailure(String message);
}

class UtilitiesAPI{

  UtilitiesCallBack _utilitiesCallBack;
  UtilitiesAPI(this._utilitiesCallBack);

  getCountryCodes(){
    _getCountryCodes().then((value) => {
      _utilitiesCallBack.onCountryCodeSuccess(value)
    }).catchError((error, stackTrace){
      _utilitiesCallBack.onCountryCodeFailure(error);
    });
  }

  Future<CountryCodeResponse> _getCountryCodes() async{
    final response = await http.get('$url' + '/countrycodes',
        headers: {
          'content-type': 'application/json'
        }
    );
    if(response.statusCode == 200){
      CountryCodeResponse countryCodeResponse = countryCodeFromJson(response.body);
      return countryCodeResponse;
    }
    else{
      throw ("Something went wrong !!");
    }
  }
}
