import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/common/const/message.dart';
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
        }

        if (state.distanceInMeters != null) {
          switch (state.distanceInMeters!) {
            case <= 200:
              showLocalPush(
                title: PUSH_TITLE,
                body: PUSH_CONTENT_NEAR,
              );
              cancelLocationSubscription();
              return;
            case <= 500:
              showLocalPush(
                title: PUSH_TITLE,
                body: PUSH_CONTENT_ONE_MINUTE,
              );
            case <= 1000:
              showLocalPush(
                title: PUSH_TITLE,
                body: PUSH_CONTENT_THREE_MINUTE,
              );
          }
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
    state = state.copyWith(subscription: subscription, isCancel: true, distanceInMeters: null);
  }
}
