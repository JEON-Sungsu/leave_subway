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
  late PermissionStatus _locationPermission;
  late ServiceStatus _locationServiceStatus;
  late PermissionStatus _notificationPermission;
  late CombinedPermissionStatus _permissionStatus;

  PermissionStatus get locationPermission => _locationPermission;

  ServiceStatus get locationServiceStatus => _locationServiceStatus;

  PermissionStatus get notificationPermission => _notificationPermission;

  CombinedPermissionStatus get permissionStatus => _permissionStatus;

  //위치 권한 요청
  Future<void> requestLocationPermission() async {
    final locationPermission = await Permission.location.status;

    if (locationPermission == PermissionStatus.denied) {
      final status = await [Permission.location].request();

      if (status[Permission.location] != null) {
        _locationPermission = status[Permission.location]!;
      } else {
        _locationPermission = PermissionStatus.denied;
      }
      return;
    }

    if (locationPermission == PermissionStatus.permanentlyDenied) {
      _locationPermission = PermissionStatus.permanentlyDenied;
      return;
    }

    _locationPermission = PermissionStatus.provisional;
  }

//GPS 사용 가능 여부 체크
  Future<void> isEnableGPS() async {
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      _locationServiceStatus = ServiceStatus.disabled;
      return;
    }

    _locationServiceStatus = ServiceStatus.enabled;
  }

  Future<void> requestNotificationPermission() async {
    final notificationPermission = await Permission.notification.status;

    if (notificationPermission == PermissionStatus.denied) {
      final status = await [Permission.notification].request();

      if (status[Permission.notification] != null) {
        _notificationPermission = status[Permission.notification]!;
      } else {
        _notificationPermission = PermissionStatus.denied;
      }
      return;
    }

    if (notificationPermission == PermissionStatus.permanentlyDenied) {
      _notificationPermission = PermissionStatus.permanentlyDenied;
      return;
    }

    _notificationPermission = PermissionStatus.provisional;
  }

  void setPermissionStatus() {
    if (_locationServiceStatus == ServiceStatus.disabled) {
      _permissionStatus = CombinedPermissionStatus.locationDisabled;
      return;
    }

    if ((_locationPermission == PermissionStatus.denied ||
            _locationPermission == PermissionStatus.permanentlyDenied) &&
        (_notificationPermission == PermissionStatus.denied ||
            _notificationPermission == PermissionStatus.permanentlyDenied)) {
      _permissionStatus = CombinedPermissionStatus.locationNotifyBothDenied;
      return;
    }

    if (_locationPermission == PermissionStatus.denied ||
        _locationPermission == PermissionStatus.permanentlyDenied) {
      _permissionStatus = CombinedPermissionStatus.locationDenied;
      return;
    }

    if (_notificationPermission == PermissionStatus.denied ||
        _notificationPermission == PermissionStatus.permanentlyDenied) {
      _permissionStatus = CombinedPermissionStatus.notifyDenied;
      return;
    }

    _permissionStatus = CombinedPermissionStatus.allGranted;
  }

  Future<void> refreshPermission() async {
    _locationPermission = await Permission.notification.status;
    _notificationPermission = await Permission.notification.status;
    _locationServiceStatus = await Permission.locationWhenInUse.serviceStatus;
    setPermissionStatus();
    print(
        '위치 갱신 $_locationPermission, 알림 갱신 $_notificationPermission, gps 갱신 $_locationServiceStatus');

    notifyListeners();
  }
}
