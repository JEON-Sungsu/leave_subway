import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/core/notification/local_notification_setting.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/seoul_metro/presentation/seoul_metro_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final PermissionManager _permissionManager = PermissionManager();
  await _permissionManager.isEnableGPS();
  await _permissionManager.requestLocationPermission();
  await _permissionManager.requestNotificationPermission();
  _permissionManager.setPermissionStatus();
  initLocalNotification();
  FlutterNativeSplash.remove();

  runApp(ChangeNotifierProvider.value(
    value: _permissionManager,
    child: const _App(),
  ));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    final _permission = context.watch<PermissionManager>();
    return MaterialApp(
      title: '내리라',
      home: FutureBuilder<bool>(
        future: _checkFirstInstall(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!) {
            return ChangeNotifierProvider.value(
              value: _permission,
              child: OnboardingScreen(isFirstInstall: snapshot.data!),
            );
          } else {
            return ChangeNotifierProvider.value(
              value: _permission,
              child: SeoulMetroScreen(isFirstInstall: snapshot.data!),
            );
          }
        },
      ),
    );
  }

  Future<bool> _checkFirstInstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;
    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', false);
    }
    return isFirstInstall;
  }
}
