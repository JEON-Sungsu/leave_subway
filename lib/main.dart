import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/home/presentation/destination_set_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  prefs = await SharedPreferences.getInstance();
  Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '내리라',
      home: FutureBuilder<bool>(
        future: _checkFirstInstall(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }

          if (snapshot.data!) {
            return OnboardingScreen();
          } else {
            return DestinationSetScreen();
          }
        },
      ),
    );
  }

  Future<bool> _checkFirstInstall() async {
    bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;
    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', false);
    }
    return isFirstInstall;
  }
}
