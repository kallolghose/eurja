import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:http/http.dart' as http;
import 'package:eurja/models/inventory/chargermodel.dart';

const url = app_constants.API_URL + "/inventory/charger";


abstract class ChargerCallBack {
  void onChargerSuccess(ChargerResponse chargerResponse);
  void onChargerFailure(String message);
}

class ChargerApi{

  Future<ChargerResponse> getAll() async {
    final response = await http.get('$url' + '/findall',
        headers: {
          'content-type': 'application/json'
        }
    );
    ChargerResponse chargerResponse = chargerFromJson(response.body);
    if(response.statusCode == 200)
      return chargerResponse;
    else
      throw ("Something went wrong !!");
  }

}