import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/model/location_service_model.dart';
import 'package:leave_subway/service/service_config.dart';

final locationServiceProvider =
    StateNotifierProvider<LocationServiceNotifier, LocationServiceModel>((ref) {
  return LocationServiceNotifier();
});

class LocationServiceNotifier extends StateNotifier<LocationServiceModel> {
  LocationServiceNotifier() : super(LocationServiceModel());

  void getStartLocationSubscription(
      double destinationLat, double destinationLon) {
    final subscription =
        Geolocator.getPositionStream(locationSettings: LOCATION_SETTING).listen(
      (Position? position) {
        if (position != null) {
          final distanceInMeters = Geolocator.distanceBetween(position.latitude,
              position.longitude, destinationLat, destinationLon);
          print(distanceInMeters);

          state = state.copyWith(
              distanceInMeters: distanceInMeters);
        }

        if (state.distanceInMeters != null) {
          switch (state.distanceInMeters!) {
            case <= 500:
              print('목적지 500미터 내외 입니다. 내릴 준비를 해주세요. ');
              cancelLocationSubscription();
              state = state.copyWith(isCancel: true);
              return;
            case <= 1000:
              print('약 3분 내외로 도착할 예정입니다.');
          }
        }
      },
    );

    state = state.copyWith(
        subscription: subscription,
        isCancel: false
    );
  }

  void cancelLocationSubscription() {
    final subscription = state.subscription;

    if (subscription == null) {
      return;
    }
    subscription.cancel();

    state = state.copyWith(subscription: subscription);
    print('구독 취소');
  }
}