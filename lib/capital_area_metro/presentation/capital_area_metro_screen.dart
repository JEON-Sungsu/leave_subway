import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/capital_area_metro/data/data_source/capital_area_metro_data_source.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_alert.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_denied.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapitalAreaMetroScreen extends StatefulWidget {
  const CapitalAreaMetroScreen({super.key});

  @override
  State<CapitalAreaMetroScreen> createState() => _CapitalAreaMetroScreenState();
}

class _CapitalAreaMetroScreenState extends State<CapitalAreaMetroScreen> {
  late StreamSubscription<Position> _positionStreamSubscription;
  final PermissionManager _permissionManager = PermissionManager();

  @override
  void initState() {
    super.initState();
    _noticePermission();
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  Future<void> _noticePermission() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('isFirstInstall')!;
    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', false);
      _showAlert();
    }
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
        body: FutureBuilder<CombinedPermissionStatus>(
          future: _permissionManager.setPermissionStatus(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data != CombinedPermissionStatus.allGranted) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PermissionDenied(permission: snapshot.data!),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.refresh),
                    )
                  ],
                ),
              );
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showAlert();
                    },
                    child: Text('얼럿'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return PermissionAlert();
      },
    );
  }
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
