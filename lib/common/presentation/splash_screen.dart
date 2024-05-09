import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

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

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled =
    await Geolocator.isLocationServiceEnabled(); //위치정보 서비스가 이용가능한 기기인지 체크
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission(); //권한 획득했는지 확인
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); //권한 요청하기
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
