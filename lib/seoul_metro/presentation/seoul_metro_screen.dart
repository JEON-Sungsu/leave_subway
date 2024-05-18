import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/seoul_metro/presentation/unauthorized/permission_denied.dart';
import 'package:provider/provider.dart';

class SeoulMetroScreen extends StatefulWidget {
  const SeoulMetroScreen({super.key});
  @override
  State<SeoulMetroScreen> createState() => _SeoulMetroScreenState();
}

class _SeoulMetroScreenState extends State<SeoulMetroScreen> {
  late StreamSubscription<Position> _positionStreamSubscription;
  final PermissionManager _permissionManager = PermissionManager.getInstance();
  void _updateUi() => setState(() {});

  @override
  void initState() {
    super.initState();
    _permissionManager.addListener(_updateUi);
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    _permissionManager.removeListener(_updateUi);
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
        body: _permissionManager.permissionStatus !=
                CombinedPermissionStatus.allGranted
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PermissionDenied(
                        permission: _permissionManager.permissionStatus),
                    IconButton(
                      onPressed: () async {
                        await _permissionManager.refreshPermission();
                      },
                      icon: Icon(Icons.refresh),
                    )
                  ],
                ),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [Text('야호')],
                ),
              ),
      ),
    );
  }

// ''void _showAlert() {
//   if (_permissionStatus == CombinedPermissionStatus.locationDenied) {
//     Platform.isIOS
//         ? showCupertinoModalPopup(
//             context: context,
//             builder: (BuildContext context) {
//               return CupertinoDialog(
//                 title: '알림',
//                 content: '본 서비스의 원활한 사용을 위해서는 기기의 위치 접근 권한 허용이 필요합니다.',
//                 hasCancelButton: false,
//                 actionButtonTitle: '확인',
//                 onPressAction: () {
//                   Navigator.pop(context, 'Cancel');
//                 },
//               );
//             })
//         : showDialog(
//             context: context,
//             builder: (context) {
//               return MaterialDialog(
//                 title: '알림',
//                 content: '본 서비스의 원활한 사용을 위해서는 기기의 위치 접근 권한 허용이 필요합니다.',
//                 hasCancelButton: false,
//                 actionButtonTitle: '확인',
//                 onPressAction: () {
//                   Navigator.pop(context, 'Cancel');
//                 },
//               );
//             },
//           );
//   }
// }''
}
// _positionStreamSubscription =
// getStartLocationSubscription(
// 37.556054, 126.982859);
// _positionStreamSubscription.onData(
// (data) {
// double distanceInMeters =
// Geolocator.distanceBetween(data.latitude,
// data.longitude, 37.566003, 126.982797);
// if (distanceInMeters <= 1000) {}
// },
// );
