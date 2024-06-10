import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/message.dart';
import 'package:leave_subway/common/const/ui_style.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';

class PermissionDenied extends StatefulWidget {
  final CombinedPermissionStatus _permission;

  const PermissionDenied(
      {super.key, required CombinedPermissionStatus permission})
      : _permission = permission;

  @override
  State<PermissionDenied> createState() => _PermissionDeniedState();
}

class _PermissionDeniedState extends State<PermissionDenied> {
  @override
  Widget build(BuildContext context) {
    if (widget._permission == CombinedPermissionStatus.locationDisabled) {
      return _GPSDisabled();
    }

    if (widget._permission ==
        CombinedPermissionStatus.locationNotifyBothDenied) {
      return _bothDenied();
    }

    return _LocationOrNotificationDenied(permission: widget._permission);
  }
}

class _bothDenied extends StatelessWidget {
  const _bothDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '본 서비스의 원활한 사용을 위해서는\n 기기의 알림허용 및 위치 접근 권한 허용이 필요합니다.',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            AppSettings.openAppSettings(type: AppSettingsType.settings);
          },
          style: PRIMARY_ELEVATED_STYLE,
          child: const Text(
            MOVE_TO_SETTING,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _GPSDisabled extends StatelessWidget {
  const _GPSDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '디바이스의 GPS 사용 기능이 활성화 되어있지 않습니다. \n GPS 기능을 활성화 해주세요.',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            AppSettings.openAppSettings(
                type: Platform.isIOS
                    ? AppSettingsType.settings
                    : AppSettingsType.location);
          },
          style: PRIMARY_ELEVATED_STYLE,
          child: const Text(
            MOVE_TO_SETTING,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationOrNotificationDenied extends StatelessWidget {
  final CombinedPermissionStatus _permission;

  const _LocationOrNotificationDenied(
      {super.key, required CombinedPermissionStatus permission})
      : _permission = permission;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _permission == CombinedPermissionStatus.locationDenied
              ? '본 서비스의 원활한 사용을 위해서는\n 디바이스의 위치 접근 권한 허용이 필요합니다.'
              : '본 서비스의 원활한 사용을 위해서는\n 디바이스의 알림 허용이 필요합니다.',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            AppSettings.openAppSettings(
                type: Platform.isIOS
                    ? AppSettingsType.settings
                    : _permission == CombinedPermissionStatus.notifyDenied
                        ? AppSettingsType.notification
                        : AppSettingsType.location);
          },
          style: PRIMARY_ELEVATED_STYLE,
          child: const Text(
            MOVE_TO_SETTING,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
