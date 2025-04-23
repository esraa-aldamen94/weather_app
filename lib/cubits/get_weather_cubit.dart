import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../models/current/current_weather_model.dart';
import '../models/forecast/forecast_weather_model.dart';
import '../states/get_weather_state.dart';

class GetWeatherCubit extends Cubit<GetWeatherState> {
  GetWeatherCubit() : super(InitGetWeatherState());

  fetchWeather(String cityName) async {
    emit(LoadingGetWeatherState());

    final currentWeatherResponse = await http.get(
      Uri.parse(
        "${ConstValues.baseUrl}current.json?key=${ConstValues.apiKey}&q=$cityName&aqi=no",
      ),
      headers: {"Accept": "application/json", "Connection": "keep-alive"},
    );

    if (currentWeatherResponse.statusCode == 200) {
      final CurrentWeatherModel currentWeatherModel =
          CurrentWeatherModel.fromJson(jsonDecode(currentWeatherResponse.body));

      final forecastWeatherResponse = await http.get(
        Uri.parse(
          "${ConstValues.baseUrl}forecast.json?key=${ConstValues.apiKey}&q=$cityName&aqi=no&days=10",
        ),
        headers: {"Accept": "application/json", "Connection": "keep-alive"},
      );
      if (forecastWeatherResponse.statusCode == 200) {
        final ForecastWeatherModel forecastWeatherModel =
            ForecastWeatherModel.fromJson(
              jsonDecode(forecastWeatherResponse.body),
            );
        emit(
          LoadedGetWeatherState(
            currentWeatherModel: currentWeatherModel,
            forecastWeatherModel: forecastWeatherModel,
          ),
        );
      } else {
        emit(
          ErrorGetWeatherState(
            errorMessage:
                "Forecast Weather Unavailable now,or the city name is wrong, try again later!",
          ),
        );
      }
    } else {
      emit(
        ErrorGetWeatherState(
          errorMessage:
              "Current Weather Unavailable now,or the city name is wrong,try again later!",
        ),
      );
    }
  }
}
