import 'package:flutter_test/flutter_test.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  group('permissionManager method test', () {
    MockManager? manager;

    tearDown(() {
      manager = null;
    });

    test(
        'locationServiceStatus가 disabled 이면 CombinedPermissionStatus.locationDisabled를 리턴한다',
        () {
      //given
      manager = MockManager(PermissionStatus.granted, ServiceStatus.disabled,
          PermissionStatus.granted);

      final value = manager!.getPermissionStatus();
      final expectValue = CombinedPermissionStatus.locationDisabled;

      expect(value, expectValue);
    });

    test(
        'locationPermission provisional 이고 나머지가 granted, enabled 이면 CombinedPermissionStatus.allGranted를 리턴한다',
            () {
          //given
          manager = MockManager(PermissionStatus.provisional, ServiceStatus.enabled,
              PermissionStatus.granted);

          final value = manager!.getPermissionStatus();
          final expectValue = CombinedPermissionStatus.allGranted;

          expect(value, expectValue);
        });

    test(
        'location = provisional, notification = denied  이면 CombinedPermissionStatus.notifyDenied를 리턴한다',
            () {
          //given
          manager = MockManager(PermissionStatus.provisional, ServiceStatus.enabled,
              PermissionStatus.denied);

          final value = manager!.getPermissionStatus();
          final expectValue = CombinedPermissionStatus.notifyDenied;

          expect(value, expectValue);
        });

    test(
        'locationPermission과 notificationPermission이 둘다 denied 또는 permanentlyDenied 라면 CombinedPermissionStatus.locationNotifyBothDenied를 리턴한다',
        () {
      //given
      manager = MockManager(PermissionStatus.permanentlyDenied,
          ServiceStatus.enabled, PermissionStatus.denied);

      final value = manager!.getPermissionStatus();
      final expectValue = CombinedPermissionStatus.locationNotifyBothDenied;

      expect(value, expectValue);
    });
  });
}

class MockManager {
  PermissionStatus locationPermission;
  ServiceStatus locationServiceStatus;
  PermissionStatus notificationPermission;

  MockManager(this.locationPermission, this.locationServiceStatus,
      this.notificationPermission);

  CombinedPermissionStatus getPermissionStatus() {
    CombinedPermissionStatus status = CombinedPermissionStatus.allGranted;

    if (locationServiceStatus == ServiceStatus.disabled) {
      status = CombinedPermissionStatus.locationDisabled;
      return status;
    }

    if (locationPermission == PermissionStatus.denied ||
        locationPermission == PermissionStatus.permanentlyDenied) {
      status = CombinedPermissionStatus.locationDenied;
    }

    if (notificationPermission == PermissionStatus.denied ||
        notificationPermission == PermissionStatus.permanentlyDenied) {
      status = CombinedPermissionStatus.notifyDenied;
    }

    if ((locationPermission == PermissionStatus.denied ||
        locationPermission == PermissionStatus.permanentlyDenied) &&
        (notificationPermission == PermissionStatus.denied ||
            notificationPermission == PermissionStatus.permanentlyDenied)) {
      status = CombinedPermissionStatus.locationNotifyBothDenied;
    }

    return status;
  }
}
