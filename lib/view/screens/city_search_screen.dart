import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/responsive.dart';
import 'package:weather_app/view/screens/weather_screen.dart';
import 'package:weather_app/view/widgets/input_widget.dart';
import 'package:weather_app/view/widgets/logo_widget.dart';
import '../../cubits/get_weather_cubit.dart';
import '../../states/get_weather_state.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController cityTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: responsiveHeight(context, 3120),
        width: responsiveWidth(context, 1440),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.jpg'),

            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black12.withAlpha((0.4 * 255).toInt()),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                const LogoWidget(),
                const SizedBox(height: 30),
                Container(
                  width: responsiveWidth(context, 1250),
                  height: responsiveHeight(context, 450),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.65 * 255).toInt()),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha((0.4 * 255).toInt()),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Name a city, and I'll share its weather !",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'cabin',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: InputWidget(
                          textEditingController: cityTextEditingController,
                          obscureText: false,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black87,
                          ),
                          label: "Search",
                          hintText: "Enter city name",
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    if (cityTextEditingController.text.isNotEmpty) {
                      final cityName = cityTextEditingController.text.trim();

                      await context.read<GetWeatherCubit>().fetchWeather(
                        cityName,
                      );

                      final state = context.read<GetWeatherCubit>().state;

                      if (state is LoadedGetWeatherState) {
                        final weatherModel = state.currentWeatherModel;
                        final forecastModel = state.forecastWeatherModel;

                        if (weatherModel != null && forecastModel != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => WeatherScreen(
                                    cityName: cityName,
                                    currentWeatherModel: weatherModel,
                                    forecastWeatherModel: forecastModel,
                                  ),
                            ),
                          );
                        }
                      } else if (state is ErrorGetWeatherState) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: responsiveWidth(context, 200),
                                      height: responsiveHeight(context, 200),
                                      child: Lottie.asset(
                                        'assets/lottie/error_logo.json',

                                        fit: BoxFit.cover,
                                      ),
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
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "OK",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                content: Column(
                                  children: [
                                    SizedBox(
                                      width: responsiveWidth(context, 200),
                                      height: responsiveHeight(context, 200),
                                      child: Lottie.asset(
                                        'assets/lottie/no_internet_logo.json',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a city name"),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.blueGrey.withAlpha((0.6 * 255).toInt()),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 35,
                    ),
                  ),
                  child: Text(
                    "Get Weather",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
