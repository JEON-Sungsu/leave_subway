import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

enum CombinedPermissionStatus {
  locationDisabled,
  locationDenied,
  notifyDenied,
  locationNotifyBothDenied,
  allGranted,
}

class PermissionManager with ChangeNotifier {
  //위치 권한 요청
  Future<void> requestLocationPermission() async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      return;
    }

    final locationPermission = await Permission.location.status;

    if (locationPermission == PermissionStatus.denied) {
      await Permission.location.request();

      return;
    }

    if (locationPermission == PermissionStatus.permanentlyDenied) {
      return;
    }
  }

  Future<void> requestNotificationPermission() async {
    final notificationPermission = await Permission.notification.status;

    if (notificationPermission == PermissionStatus.denied) {
      await Permission.notification.request();

      return;
    }

    if (notificationPermission == PermissionStatus.permanentlyDenied) {
      return;
    }
  }

  Future<CombinedPermissionStatus> setPermissionStatus() async {
    final locationPermission = await Permission.location.status;
    final notificationPermission = await Permission.notification.status;

    if ((locationPermission == PermissionStatus.denied ||
            locationPermission == PermissionStatus.permanentlyDenied) &&
        (notificationPermission == PermissionStatus.denied ||
            notificationPermission == PermissionStatus.permanentlyDenied)) {

      return CombinedPermissionStatus.locationNotifyBothDenied;
    }

    if (locationPermission == PermissionStatus.denied ||
        locationPermission == PermissionStatus.permanentlyDenied) {
      return CombinedPermissionStatus.locationDenied;
    }

    if (notificationPermission == PermissionStatus.denied ||
        notificationPermission == PermissionStatus.permanentlyDenied) {
      return CombinedPermissionStatus.notifyDenied;
    }

    return CombinedPermissionStatus.allGranted;
  }
}
