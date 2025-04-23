import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CurrentWeatherLogo extends StatelessWidget {
  final String weatherCondition;

  const CurrentWeatherLogo({super.key, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    String lottieAnimation;

    if (weatherCondition.contains('sunny') ||
        weatherCondition.contains('clear')) {
      lottieAnimation = 'assets/lottie/sunny2_logo.json';
    } else if (weatherCondition.contains('rainy') ||
        weatherCondition.contains('drizzle')) {
      lottieAnimation = 'assets/lottie/rainy_logo.json';
    } else if (weatherCondition.contains('cloud')) {
      lottieAnimation = 'assets/lottie/cloudy_logo.json';
    } else if (weatherCondition.contains('snow')) {
      lottieAnimation = 'assets/lottie/snow_logo.json';
    } else {
      return SizedBox();
    }

    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          weatherCondition.contains('snow')
              ? SizedBox(
                width: 100,
                height: 180,
                child: Lottie.asset(lottieAnimation, repeat: true),
              )
              : Lottie.asset(lottieAnimation, width: 130, repeat: true),
        ],
      ),
    );
  }
}
