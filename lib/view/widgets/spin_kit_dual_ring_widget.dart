import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class SpinKitDualRingWidget extends StatefulWidget {
  const SpinKitDualRingWidget({super.key});

  @override
  _SpinKitDualRingWidgetState createState() => _SpinKitDualRingWidgetState();
}

class _SpinKitDualRingWidgetState extends State<SpinKitDualRingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDualRing(
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          Text(
            'Loading......',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
