import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/component/cupertino_dialog.dart';
import 'package:leave_subway/common/component/material_dialog.dart';

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
    return const Scaffold(
      body: Center(
        child: Text('하이'),
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
              content: '기기 위치에 접근 권한을 허용해야 원활한 서비스 이용이 가능합니다.',
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
            content: '기기 위치에 접근 권한을 허용해야 원활한 서비스 이용이 가능합니다.',
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

