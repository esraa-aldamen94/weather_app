import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../responsive.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/search_logo.json',
        width: responsiveWidth(context, 600),
        height: responsiveHeight(context, 600),
      ),
    );
  }
}
