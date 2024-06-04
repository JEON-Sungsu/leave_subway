import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/presentation/component/destination_list_item.dart';
import 'package:leave_subway/capital_area_metro/presentation/component/permission_alert.dart';
import 'package:leave_subway/capital_area_metro/presentation/component/permission_denied.dart';
import 'package:leave_subway/capital_area_metro/presentation/provider/capital_area_metro_screen_provider.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';
import 'package:leave_subway/common/presentation/bottom_sheet.dart';
import 'package:leave_subway/common/presentation/default_layout.dart';
import 'package:leave_subway/service/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapitalAreaMetroScreen extends ConsumerStatefulWidget {
  const CapitalAreaMetroScreen({super.key});

  @override
  ConsumerState<CapitalAreaMetroScreen> createState() =>
      _CapitalAreaMetroScreenState();
}

class _CapitalAreaMetroScreenState
    extends ConsumerState<CapitalAreaMetroScreen> {
  final PermissionManager _permissionManager = PermissionManager();
  bool _isSnackBarShow = false;
  String _trackingId = '';

  @override
  void initState() {
    super.initState();
    _noticePermission();
  }

  Future<void> _noticePermission() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('isFirstInstall')!;
    if (isFirstInstall) {
      await prefs.setBool('isFirstInstall', false);
      _showAlert();
    }
  }

  void _showSnackBar(String content) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      duration: Duration(seconds: 2),
      onVisible: () {
        _isSnackBarShow = true;
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      _isSnackBarShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(capitalAreaMetroScreenProvider);
    final stateRead = ref.read(capitalAreaMetroScreenProvider.notifier);
    final locationState = ref.watch(locationServiceProvider);
    final locationRead = ref.read(locationServiceProvider.notifier);

    ref.listen(capitalAreaMetroScreenProvider, (_, state) {
      if (state.isOtherTracking && !_isSnackBarShow) {
        _showSnackBar('현재 추적중인 목적지의 추적 종료 후 실행해주세요.');
      }
    });

    ref.listen(locationServiceProvider, (_, state) {
      if (state.distanceInMeters != null) {
        if (state.isCancel && state.distanceInMeters! <= 200) {
          stateRead.toggleTracking(_trackingId);
        }
      }
    });

    return DefaultLayout(
      title: '내리라',
      action: IconButton(
        onPressed: () {
          stateRead.initWheelScroll();
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
                  child: ListView.builder(
                      itemCount: state.destinations.length,
                      itemBuilder: (_, index) {
                        final model = state.destinations[index];
                        return DestinationListItem(
                          line: model.line,
                          name: model.name,
                          isTracking: model.isTracking,
                          onPressedDelete: () {
                            stateRead.removeDestination(model.id);
                          },
                          onValueChanged: (value) {
                            _trackingId = model.id;
                            stateRead.toggleTracking(model.id);

                            if (value) {
                              locationRead.getStartLocationSubscription(
                                  model.lat, model.lng);
                            } else {
                              locationRead.cancelLocationSubscription();
                            }
                          },
                        );
                      }),
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
}
