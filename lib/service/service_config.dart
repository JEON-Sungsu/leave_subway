import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

final LocationSettings LOCATION_SETTING =
    defaultTargetPlatform == TargetPlatform.android
        ? AndroidSettings(
            accuracy: LocationAccuracy.best,
            distanceFilter: 300,
            forceLocationManager: true,
            intervalDuration: const Duration(seconds: 30),
            foregroundNotificationConfig: const ForegroundNotificationConfig(
              notificationText: "위치 서비스 이용중",
              notificationTitle: "서비스 이용을 위해, 사용자의 위치정보를 이용중입니다.",
              enableWakeLock: true,
            ),
          )
        : AppleSettings(
            accuracy: LocationAccuracy.best,
            activityType: ActivityType.fitness,
            distanceFilter: 300,
            pauseLocationUpdatesAutomatically: true,
            showBackgroundLocationIndicator: true,
          );
