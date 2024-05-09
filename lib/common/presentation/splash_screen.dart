import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: Lottie.asset('asset/json/splash_temp.json',
                width: 200, height: 200),
          ),
        ),
      ),
    );
  }
}
