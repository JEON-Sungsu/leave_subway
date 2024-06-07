import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, CombinedPermissionStatus>(
        (ref) => PermissionNotifier());

class PermissionNotifier extends StateNotifier<CombinedPermissionStatus> {
  PermissionNotifier() : super(CombinedPermissionStatus.initialState);

  //위치 권한 요청
  Future<void> requestLocationPermission() async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      state = CombinedPermissionStatus.locationDisabled;
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

  Future<void> setPermissionStatus() async {
    final locationPermission = await Permission.location.status;
    final notificationPermission = await Permission.notification.status;

    if ((locationPermission == PermissionStatus.denied ||
            locationPermission == PermissionStatus.permanentlyDenied) &&
        (notificationPermission == PermissionStatus.denied ||
            notificationPermission == PermissionStatus.permanentlyDenied)) {
      state = CombinedPermissionStatus.locationNotifyBothDenied;
      return;
    }

    if (locationPermission == PermissionStatus.denied ||
        locationPermission == PermissionStatus.permanentlyDenied) {
      state = CombinedPermissionStatus.locationDenied;
      return;
    }

    if (notificationPermission == PermissionStatus.denied ||
        notificationPermission == PermissionStatus.permanentlyDenied) {
      state = CombinedPermissionStatus.notifyDenied;
      return;
    }

    state = CombinedPermissionStatus.allGranted;
  }
}

enum CombinedPermissionStatus {
  initialState,
  locationDisabled,
  locationDenied,
  notifyDenied,
  locationNotifyBothDenied,
  allGranted,
}
