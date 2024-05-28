import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/capital_area_metro/presentation/provider/capital_area_metro_screen_provider.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/common/model/destination_list_model.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/capital_area_metro/data/data_source/capital_area_metro_data_source.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_alert.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_denied.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapitalAreaMetroScreen extends ConsumerStatefulWidget {
  const CapitalAreaMetroScreen({super.key});

  @override
  ConsumerState<CapitalAreaMetroScreen> createState() =>
      _CapitalAreaMetroScreenState();
}

class _CapitalAreaMetroScreenState
    extends ConsumerState<CapitalAreaMetroScreen> {
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
    final state = ref.watch(capitalAreaMetroScreenProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              const Text('내리라', style: TextStyle(fontWeight: FontWeight.w700)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
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

            return Column(
              children: [

              ],
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
