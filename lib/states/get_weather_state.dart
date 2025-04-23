import '../models/current/current_weather_model.dart';
import '../models/forecast/forecast_weather_model.dart';

abstract class GetWeatherState {}

class InitGetWeatherState extends GetWeatherState {}

class LoadingGetWeatherState extends GetWeatherState {}

class LoadedGetWeatherState extends GetWeatherState {
  CurrentWeatherModel currentWeatherModel;
  ForecastWeatherModel forecastWeatherModel;

  LoadedGetWeatherState({
    required this.currentWeatherModel,
    required this.forecastWeatherModel,
  });
}

class ErrorGetWeatherState extends GetWeatherState {
  String? errorMessage;

  ErrorGetWeatherState({this.errorMessage});
}
