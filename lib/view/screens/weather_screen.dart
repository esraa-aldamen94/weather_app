import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../cubits/get_weather_cubit.dart';
import '../../models/current/current_weather_model.dart';
import '../../models/forecast/forecast_day.dart';
import '../../models/forecast/forecast_weather_model.dart';
import '../../models/forecast/hour.dart';
import '../../states/get_weather_state.dart';
import '../widgets/spin_kit_dual_ring_widget.dart';
import '../widgets/current_weather_logo.dart';
import 'map_screen.dart';

class WeatherScreen extends StatefulWidget {
  final String cityName;
  final CurrentWeatherModel currentWeatherModel;
  final ForecastWeatherModel forecastWeatherModel;

  const WeatherScreen({
    super.key,
    required this.cityName,
    required this.currentWeatherModel,
    required this.forecastWeatherModel,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ("Weather Details"),
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final location = widget.currentWeatherModel.location;
              final current = widget.currentWeatherModel.current;
              final forecastDays =
                  widget.forecastWeatherModel.forecast?.forecastday;

              if (location?.lat != null &&
                  location?.lon != null &&
                  current != null &&
                  forecastDays != null &&
                  forecastDays.isNotEmpty) {
                final forecastDay = forecastDays[0];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MapScreen(
                          latitude: location!.lat!,
                          longitude: location.lon!,
                          temperature: current.tempC.toString(),
                          maxTempC: forecastDay.day?.maxtempC ?? 0.0,
                          minTempC: forecastDay.day?.mintempC ?? 0.0,
                        ),
                  ),
                );
              }
            },
            icon: Icon(Icons.map_outlined, color: Colors.black, size: 30),
          ),
        ],
      ),
      body: BlocBuilder<GetWeatherCubit, GetWeatherState>(
        builder: (context, state) {
          if (state is LoadingGetWeatherState) {
            return Center(child: SpinKitDualRingWidget());
          } else if (state is LoadedGetWeatherState) {
            final currentWeather = state.currentWeatherModel;
            final forecastWeather = state.forecastWeatherModel;

            if (currentWeather.current == null ||
                forecastWeather.forecast == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/no_data_available_logo.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            }
            String weatherCondition =
                currentWeather.current?.condition?.text?.toLowerCase() ?? '';
            String backgroundImage;

            if (weatherCondition.contains('sunny') ||
                weatherCondition.contains('clear')) {
              backgroundImage = 'assets/images/sunny.png';
            } else if (weatherCondition.contains('rain') ||
                weatherCondition.contains('drizzle')) {
              backgroundImage = 'assets/images/rainy.jpg';
            } else if (weatherCondition.contains('cloud')) {
              backgroundImage = 'assets/images/cloudy.jpg';
            } else if (weatherCondition.contains('snow')) {
              backgroundImage = 'assets/images/snow_background.jpeg';
            } else {
              return Center(child: CircularProgressIndicator());
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha((0.5 * 255).toInt()),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Text(
                        ' ${currentWeather.location?.localtime}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 200,
                        width: 350,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${currentWeather.location?.name}, ${currentWeather.location?.country}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Feels Like: ${currentWeather.current?.feelslikeC} °C',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '${currentWeather.current?.tempC}°C',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CurrentWeatherLogo(
                              weatherCondition: weatherCondition,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${currentWeather.current?.condition?.text}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.center,
                        children: [
                          weatherCard(
                            'Humidity: ${currentWeather.current?.humidity}%',
                          ),
                          weatherCard(
                            'Wind Speed: ${currentWeather.current?.windKph} km/h',
                          ),
                          weatherCard(
                            'Cloud: ${currentWeather.current?.cloud}%',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "   Hourly Forecast ⛅",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            color: Colors.black.withAlpha((0.5 * 255).toInt()),
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  forecastWeather
                                      .forecast
                                      ?.forecastday?[0]
                                      .hour
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                Hour hour =
                                    forecastWeather
                                        .forecast!
                                        .forecastday![0]
                                        .hour![index];
                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        hour.getFormattedTime(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(height: 8),
                                      Text(
                                        '${hour.tempC} °C',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Image.network(
                                        'https:${hour.condition?.icon}',
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            hour.chanceOfRain != null
                                                ? "${hour.chanceOfRain}%"
                                                : "0",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                forecastWeather.forecast?.forecastday?.length,
                            itemBuilder: (context, index) {
                              Forecastday day =
                                  forecastWeather.forecast!.forecastday![index];

                              return Card(
                                shadowColor: Colors.black,
                                elevation: 5,
                                margin: EdgeInsets.all(12.0),
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        day.date ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Divider(color: Colors.grey, thickness: 1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Image.network(
                                                'https:${day.day?.condition?.icon}',
                                                width: 50,
                                                height: 50,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                '${day.day?.condition?.text}',
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Text(
                                                'H: ${day.day?.maxtempC}°C / L: ${day.day?.mintempC}°C',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.water_drop,
                                                    color: Colors.blue,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '${day.day?.dailyChanceOfRain}%',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.air,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    '${day.day?.maxwindKph} km/h',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/sunrise_icon.png",
                                                    width: 20,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text('${day.astro?.sunrise}'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/sunset_icon.jpeg",
                                                    width: 20,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text('${day.astro?.sunset}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ErrorGetWeatherState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/error_logo.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Error: ${state.errorMessage}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/no_internet_logo.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Something went wrong!',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget weatherCard(String text) {
  return Card(
    margin: EdgeInsets.all(2.0),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.white.withAlpha((0.5 * 255).toInt()),
    child: Padding(
      padding: EdgeInsets.all(4.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
