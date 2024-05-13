import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/core/notification/local_notification_setting.dart';
import 'package:leave_subway/home/presentation/destination_set_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _locationServiceEnabled;
  late LocationPermission _locationPermission;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    initLocalNotification();

    // Future.delayed(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //       builder: (_) => DestinationSetScreen(
    //         locationServiceEnabled: _locationServiceEnabled,
    //         locationPermission: _locationPermission,
    //       ),
    //     ),
    //         (route) => false,
    //   );
    // });
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
            child: Lottie.asset('asset/json/splash_metro.json',
                width: 200, height: 200),
          ),
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    _locationServiceEnabled =
        await Geolocator.isLocationServiceEnabled(); //위치정보 서비스가 이용가능한 기기인지 체크

    _locationPermission = await Geolocator.checkPermission(); //권한 획득했는지 확인
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission(); //권한 요청하기
    }

    if (_locationPermission == LocationPermission.deniedForever) {
      _locationPermission = LocationPermission.deniedForever;
    }
  }
}
