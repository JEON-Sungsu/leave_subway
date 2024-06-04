import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/model/location_service_model.dart';
import 'package:leave_subway/service/notification_service.dart';
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
          state = state.copyWith(
            distanceInMeters: distanceInMeters,
            isCancel: false,
          );
          print(distanceInMeters);
        }

        if (state.distanceInMeters != null) {
          switch (state.distanceInMeters!) {
            case <= 200:
              showLocalPush(
                title: '목적지 도착 알림',
                body: '목적지 부근 입니다. 추적을 종료 합니다.',
              );
              cancelLocationSubscription();
              return;
            case <= 500:
              showLocalPush(
                title: '목적지 도착 알림',
                body: '도착 1분 내외 입니다. 하차 준비 해주세요!',
              );
            case <= 1000:
              showLocalPush(
                title: '목적지 도착 알림',
                body: '약 3분 내외로 도착할 예정 입니다.',
              );
          }
        } else {

        }
      },
    );

    state = state.copyWith(subscription: subscription, isCancel: false);
  }

  void cancelLocationSubscription() {
    final subscription = state.subscription;

    if (subscription == null) {
      return;
    }
    subscription.cancel();

    state = state.copyWith(subscription: subscription, isCancel: true);
    print('구독 취소');
  }
}
