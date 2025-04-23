
import 'package:weather_app/models/current/condition.dart';

class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? maxwindKph;
  int? avghumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  Condition? condition;
  double? uv;

  Day(
      {this.maxtempC,
        this.mintempC,
        this.avgtempC,
        this.maxwindKph,
        this.avghumidity,
        this.dailyWillItRain,
        this.dailyChanceOfRain,
        this.condition,
        this.uv});

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    maxwindKph = json['maxwind_kph'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    condition = json['condition'] != null
        ?  Condition.fromJson(json['condition'])
        : null;
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['maxtemp_c'] = maxtempC;
    data['mintemp_c'] = mintempC;
    data['avgtemp_c'] = avgtempC;
    data['maxwind_kph'] = maxwindKph;
    data['avghumidity'] = avghumidity;
    data['daily_will_it_rain'] = dailyWillItRain;
    data['daily_chance_of_rain'] =dailyChanceOfRain;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['uv'] = uv;
    return data;
  }
}