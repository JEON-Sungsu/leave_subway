import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/home/presentation/destination_set_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final PermissionManager permissionManager = PermissionManager();
  await permissionManager.isEnableGPS();
  await permissionManager.requestLocationPermission();
  await permissionManager.requestNotificationPermission();
  FlutterNativeSplash.remove();

  runApp(ChangeNotifierProvider(
    create: (_) => permissionManager,
    child: const _App(),
  ));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    final permission = context.watch<PermissionManager>();
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
            return OnboardingScreen(
              locationPermission: permission.locationPermission,
              notificationPermission: permission.notificationPermission,
              locationServiceStatus: permission.locationServiceStatus,
            );
          } else {
            return DestinationSetScreen(
              locationPermission: permission.locationPermission,
              notificationPermission: permission.notificationPermission,
              locationServiceStatus: permission.locationServiceStatus,
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
