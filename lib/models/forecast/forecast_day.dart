import 'astro.dart';
import 'day.dart';
import 'hour.dart';

class Forecastday {
  String? date;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday({this.date, this.day, this.astro, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ?  Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ?  Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(Hour.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['date'] = date;
    if (day != null) {
      data['day'] = day!.toJson();
    }
    if (astro != null) {
      data['astro'] = astro!.toJson();
    }
    if (hour != null) {
      data['hour'] = hour!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
