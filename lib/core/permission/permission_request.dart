import 'package:permission_handler/permission_handler.dart';

//위치 권한 요청
Future<PermissionStatus> requestLocationPermission() async {
  final locationPermission = await Permission.location.status;

  if (locationPermission == PermissionStatus.denied) {
    final status = await [Permission.location].request();

    if (status[Permission.location] != null) {
      return status[Permission.location]!;
    }
  }

  if (locationPermission == PermissionStatus.permanentlyDenied) {
    return PermissionStatus.permanentlyDenied;
  }

  return PermissionStatus.provisional;
}
//GPS 사용 가능 여부 체크
Future<ServiceStatus> isEnableGPS() async {
  if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
    return ServiceStatus.disabled;
  }

  return ServiceStatus.enabled;
}

Future<PermissionStatus> requestNotificationPermission() async {
  final notificationPermission = await Permission.notification.status;

  if (notificationPermission == PermissionStatus.denied) {
    final status = await [Permission.notification].request();

    if (status[Permission.notification] != null) {
      return status[Permission.notification]!;
    }
  }

  if (notificationPermission == PermissionStatus.permanentlyDenied) {
    return PermissionStatus.permanentlyDenied;
  }

  return PermissionStatus.provisional;
}