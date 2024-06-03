import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:leave_subway/service/service_config.dart';

StreamSubscription<Position> getStartLocationSubscription(
    double destinationLat, double destinationLon) {
  final subscription =
      Geolocator.getPositionStream(locationSettings: LOCATION_SETTING).listen(
    (Position? position) {
      print('위치추적 시작');
    },
  );

  return subscription;
}
