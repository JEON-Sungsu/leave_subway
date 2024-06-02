import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';
import 'package:leave_subway/capital_area_metro/presentation/provider/capital_area_metro_screen_provider.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/common/presentation/bottom_sheet.dart';
import 'package:leave_subway/common/presentation/default_layout.dart';
import 'package:leave_subway/core/permission/permission_manager.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_alert.dart';
import 'package:leave_subway/capital_area_metro/presentation/first_install/permission_denied.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

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

    ref.listen(capitalAreaMetroScreenProvider, (_, state) {
      if (state.isOtherTracking) {
        final snackBar = SnackBar(
          content: Text('현재 추적중인 목적지의 추적 종료 후 실행해주세요.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    return DefaultLayout(
      title: '내리라',
      action: IconButton(
        onPressed: () {
          ref.read(capitalAreaMetroScreenProvider.notifier).initializeScroll();
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return DestinationBottomSheet();
            },
            useSafeArea: true,
            isScrollControlled: true,
          );
        },
        icon: Icon(Icons.add),
      ),
      child: FutureBuilder<CombinedPermissionStatus>(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (state.destinations.isEmpty && !state.isLoading)
                Center(
                  child: Text(
                    '등록된 목적지가 존재하지 않습니다.\n 목적지를 등록해주세요.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (!state.destinations.isEmpty)
                Expanded(
                  child: ListView.separated(
                    itemCount: state.destinations.length,
                    itemBuilder: (_, index) {
                      final model = state.destinations[index];
                      return _renderDestinationList(model: model);
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(),
                        ),
                      );
                    },
                  ),
                )
            ],
          );
        },
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

  Padding _renderDestinationList({required Metro model}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.line,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                model.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: model.isTracking ? PRIMARY_COLOR : Colors.grey,
                ),
              ),
            ],
          ),
          if (model.isTracking)
            Expanded(
              child: Shimmer.fromColors(
                baseColor: PRIMARY_COLOR,
                highlightColor: Colors.white,
                child: const Text(
                  '추적중 ········',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          else
            Spacer(),
          CupertinoSwitch(
            value: model.isTracking,
            onChanged: (value) {
              ref
                  .read(capitalAreaMetroScreenProvider.notifier)
                  .toggleTracking(model.id);
            },
          ),
          IconButton(
              onPressed: () {
                ref
                    .read(capitalAreaMetroScreenProvider.notifier)
                    .deleteDestination(model.id);
              },
              icon: Icon(
                Icons.close,
                size: 16.0,
              ))
        ],
      ),
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
