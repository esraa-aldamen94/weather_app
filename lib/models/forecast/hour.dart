import 'package:weather_app/models/current/condition.dart';
import 'package:intl/intl.dart';

class Hour {
  String? time;
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  int? chanceOfRain;
  double? uv;

  Hour(
      {this.time,
        this.tempC,
        this.isDay,
        this.condition,
        this.windKph,
        this.humidity,
        this.cloud,
        this.feelslikeC,
        this.chanceOfRain,
        this.uv});

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = (json['temp_c'] as num?)?.toDouble();
    isDay = json['is_day'];
    condition = json['condition'] != null
        ?  Condition.fromJson(json['condition'])
        : null;
    windKph = (json['wind_kph'] as num?)?.toDouble();
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = (json['feelslike_c'] as num?)?.toDouble();
    chanceOfRain = json['chance_of_rain'];
    uv = (json['uv'] as num?)?.toDouble();
  }
  String getFormattedTime() {
    DateTime dateTime = DateTime.parse(time!);
    return DateFormat('hh:mm a').format(dateTime);}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['time'] = time;
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['chance_of_rain'] = chanceOfRain;
    data['uv'] = uv;
    return data;
  }
}