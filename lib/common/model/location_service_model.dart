import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

@immutable
class LocationServiceModel {
  final StreamSubscription<Position>? subscription;
  final double? distanceInMeters;
  final bool isCancel;

  LocationServiceModel({
    this.isCancel = false,
    this.subscription,
    this.distanceInMeters,
  });

  LocationServiceModel copyWith({
    bool? isCancel,
    StreamSubscription<Position>? subscription,
    double? distanceInMeters,
  }) {
    return LocationServiceModel(
      isCancel: isCancel ?? this.isCancel,
      subscription: subscription ?? this.subscription,
      distanceInMeters: distanceInMeters ?? this.distanceInMeters,
    );
  }
}
