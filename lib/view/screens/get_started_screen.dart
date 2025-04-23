import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/view/screens/city_search_screen.dart';
import '../../responsive.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFede4e8),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: responsiveHeight(context, 850),
                width: responsiveWidth(context, 650),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/start.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black12.withAlpha((0.4 * 255).toInt()),
                      BlendMode.lighten,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
             Text(
              "Weather Application",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF06a88b),
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF06a88b),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CitySearchScreen(),
                    ),
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.sp
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
