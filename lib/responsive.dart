import 'package:flutter/material.dart';

/// Function to calculate responsive height based on screen dimensions.
/// It adjusts the given height proportionally to the screen size.
///
/// [value] : The target height you want.
/// [baseHeight] : The base height of the screen you're designing on (e.g., 932).
///
/// Returns a double value for the responsive height.
double responsiveHeight(BuildContext context, double value,
    {double baseHeight = 3120}) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (value / baseHeight) * screenHeight;
}

/// Function to calculate responsive width based on screen dimensions.
/// It adjusts the given width proportionally to the screen size.
///
/// [value] : The target width you want.
/// [baseWidth] : The base width of the screen you're designing on (e.g., 430).
///
/// Returns a double value for the responsive width.
double responsiveWidth(BuildContext context, double value,
    {double baseWidth = 1440}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (value / baseWidth) * screenWidth;
}