class Astro {
  String? sunrise;
  String? sunset;

  Astro({this.sunrise, this.sunset});

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}
