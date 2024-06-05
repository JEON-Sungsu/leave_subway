import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/presentation/screen/capital_area_metro_screen.dart';
import 'package:leave_subway/common/const/message.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';

import 'package:leave_subway/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final PermissionManager permissionManager = PermissionManager();
  await permissionManager.requestLocationPermission();
  await permissionManager.requestNotificationPermission();
  initLocalNotification();
  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      child: const _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      home: FutureBuilder<bool>(
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
