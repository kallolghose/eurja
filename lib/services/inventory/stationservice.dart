import 'package:eurja/constants/app_constants.dart' as app_constants;
import 'package:http/http.dart' as http;
import 'package:eurja/models/inventory/stationmodel.dart';

const url = app_constants.API_URL + "/inventory/station";

abstract class StationCallBack {
  void onStationSuccess(StationResponse stationResponse);
  void onStationFailure(String message);
}

class StationApi{

  StationCallBack _stationCallBack;
  StationApi(this._stationCallBack);

  getAllStations(){
    getAll().then((value) => {
      _stationCallBack.onStationSuccess(value)
    }).catchError((onError, stackTrace){
      print(stackTrace);
      _stationCallBack.onStationFailure("Something went wrong");
    });
  }

  Future<StationResponse> getAll() async {
    final response = await http.get('$url' + '/all',
        headers: {
          'content-type': 'application/json'
        }
    );
    print(response.statusCode);
    if(response.statusCode == 200) {
      StationResponse stationResponse = stationFromJson(response.body);
      return stationResponse;
    }
    else
      throw ("Something went wrong !!");
  }
}