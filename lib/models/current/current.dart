import 'condition.dart';
class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? uv;

  Current(
      {this.lastUpdatedEpoch,
        this.lastUpdated,
        this.tempC,
        this.isDay,
        this.condition,
        this.windKph,
        this.humidity,
        this.cloud,
        this.feelslikeC,
        this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ?  Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['last_updated_epoch'] = lastUpdatedEpoch;
    data['last_updated'] = lastUpdated;
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['uv'] = uv;
    return data;
  }
}