import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/common/const/message.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';
import 'package:leave_subway/common/router/router.dart';

import 'package:leave_subway/service/notification_service.dart';

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
    return MaterialApp.router(
      routerConfig: router,
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
    );
  }
}
