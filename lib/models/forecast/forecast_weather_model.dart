import 'package:weather_app/models/current/current.dart';
import 'package:weather_app/models/current/location.dart';
import 'package:weather_app/models/forecast/forecast.dart';

class ForecastWeatherModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  ForecastWeatherModel({this.location, this.current, this.forecast});

  ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ?  Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ?  Forecast.fromJson(json['forecast'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (forecast != null) {
      data['forecast'] = forecast!.toJson();
    }
    return data;
  }
}