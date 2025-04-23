import 'current.dart';
import 'location.dart';

class CurrentWeatherModel {
  Location? location;
  Current? current;

  CurrentWeatherModel({this.location, this.current});

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ?  Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ?  Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}
