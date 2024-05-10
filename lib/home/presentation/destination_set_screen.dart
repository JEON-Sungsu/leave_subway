import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/component/cupertino_dialog.dart';
import 'package:leave_subway/common/component/material_dialog.dart';
import 'package:app_settings/app_settings.dart';
import 'package:leave_subway/common/const/color.dart';

class DestinationSetScreen extends StatefulWidget {
  final bool _serviceEnabled;
  final LocationPermission _permission;

  const DestinationSetScreen({
    super.key,
    required bool serviceEnabled,
    required LocationPermission permission,
  })  : _serviceEnabled = serviceEnabled,
        _permission = permission;

  @override
  State<DestinationSetScreen> createState() => _DestinationSetScreenState();
}

class _DestinationSetScreenState extends State<DestinationSetScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _showAlert();
    });
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
        body: widget._permission == LocationPermission.denied ||
                widget._permission == LocationPermission.deniedForever
            ? Center(
                child: _PermissionDeniedForeverUI(
                  serviceEnabled: widget._serviceEnabled,
                ),
              )
            : const Center(
                child: Text('권한 허용 됨'),
              ),
      ),
    );
  }

  void _showAlert() {
    if (widget._permission == LocationPermission.denied ||
        widget._permission == LocationPermission.deniedForever) {
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

class _PermissionDeniedForeverUI extends StatelessWidget {
  final bool _serviceEnabled;

  const _PermissionDeniedForeverUI({super.key, required bool serviceEnabled})
      : _serviceEnabled = serviceEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _serviceEnabled
                ? '본 서비스의 원활한 사용을 위해서는\n 기기의 위치 접근 권한 허용이 필요합니다.'
                : '해당 디바이스는, 위치정보수집 기능이 불가능한 디바이스 입니다.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          if (_serviceEnabled)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  AppSettings.openAppSettings(
                      type: Platform.isIOS
                          ? AppSettingsType.settings
                          : AppSettingsType.location);
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
