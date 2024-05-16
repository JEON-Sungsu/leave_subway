import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/component/cupertino_dialog.dart';
import 'package:leave_subway/common/component/material_dialog.dart';
import 'package:app_settings/app_settings.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/core/location/location_setting.dart';
import 'package:leave_subway/core/notification/local_notification_setting.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class DestinationSetScreen extends StatefulWidget {
  final permission.PermissionStatus _locationPermission;
  final permission.PermissionStatus _notificationPermission;
  final permission.ServiceStatus _locationServiceStatus;

  const DestinationSetScreen({
    super.key,
    required permission.PermissionStatus locationPermission,
    required permission.PermissionStatus notificationPermission,
    required permission.ServiceStatus locationServiceStatus,
  })  : _locationPermission = locationPermission,
        _notificationPermission = notificationPermission,
        _locationServiceStatus = locationServiceStatus;

  @override
  State<DestinationSetScreen> createState() => _DestinationSetScreenState();
}

class _DestinationSetScreenState extends State<DestinationSetScreen> {
  late StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    initLocalNotification();
    // Future.microtask(() {
    //   _showAlert();
    // });
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text('내리라', style: TextStyle(fontWeight: FontWeight.w700)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz_outlined),
            ),
          ],
        ),
        body: widget._locationPermission == permission.PermissionStatus.denied ||
            widget._locationPermission ==
                    permission.PermissionStatus.permanentlyDenied
            ? const Center(
                child: _locationPermissionDeniedForeverUI(),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _positionStreamSubscription =
                              getStartLocationSubscription(
                                  37.556054, 126.982859);
                          _positionStreamSubscription.onData((data) {
                            double distanceInMeters =
                                Geolocator.distanceBetween(data.latitude,
                                    data.longitude, 37.566003, 126.982797);
                            print(distanceInMeters);
                            print('${data.latitude}, ${data.longitude}');
                            if (distanceInMeters <= 1000) {
                              print('목적지 1km 이내입니다.');
                            }
                          });
                        });
                      },
                      child: const Text('위치추적 시작'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print('버튼눌림');
                        NotificationDetails details = const NotificationDetails(
                          iOS: DarwinNotificationDetails(
                            presentAlert: true,
                            presentBadge: true,
                            presentSound: true,
                          ),
                          android: AndroidNotificationDetails(
                              "show_test", "show_test",
                              importance: Importance.max,
                              priority: Priority.high,
                              icon: 'ic_launcher'),
                        );
                        await localNotification.show(
                          0,
                          "타이틀이 보여지는 영역입니다.",
                          "컨텐츠 내용이 보여지는 영역입니다.",
                          details,
                        );
                      },
                      child: const Text('푸쉬알림 테스트'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void _showAlert() {
    if (widget._locationPermission == permission.PermissionStatus.denied ||
        widget._locationPermission == permission.PermissionStatus.permanentlyDenied) {
      Platform.isIOS
          ? showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoDialog(
                  title: '알림',
                  content: '본 서비스의 원활한 사용을 위해서는 기기의 위치 접근 권한 허용이 필요합니다.',
                  hasCancelButton: false,
                  actionButtonTitle: '확인',
                  onPressAction: () {
                    Navigator.pop(context, 'Cancel');
                  },
                );
              })
          : showDialog(
              context: context,
              builder: (context) {
                return MaterialDialog(
                  title: '알림',
                  content: '본 서비스의 원활한 사용을 위해서는 기기의 위치 접근 권한 허용이 필요합니다.',
                  hasCancelButton: false,
                  actionButtonTitle: '확인',
                  onPressAction: () {
                    Navigator.pop(context, 'Cancel');
                  },
                );
              },
            );
    }
  }
}

class _locationPermissionDeniedForeverUI extends StatelessWidget {
  const _locationPermissionDeniedForeverUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '본 서비스의 원활한 사용을 위해서는\n 기기의 위치 접근 권한 허용이 필요합니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                AppSettings.openAppSettings(
                    type: Platform.isIOS
                        ? AppSettingsType.settings
                        : AppSettingsType.settings);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                '설정으로 이동하기',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
