import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/presentation/screen/capital_area_metro_screen.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  @override
  void initState() {
    super.initState();WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    _permissionRequest();
    initLocalNotification();
    FlutterNativeSplash.remove();
    initLocalNotification();
  }

  _permissionRequest() async {
    await ref.read(permissionProvider.notifier).requestLocationPermission();
    await ref.read(permissionProvider.notifier).requestNotificationPermission();
    await ref.read(permissionProvider.notifier).setPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkFirstInstall(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!) {
            return OnboardingScreen();
          } else {
            return CapitalAreaMetroScreen();
          }
        },
      ),
    );
  }

  Future<bool> _checkFirstInstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;

    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', true);
    }

    return isFirstInstall;
  }
}
