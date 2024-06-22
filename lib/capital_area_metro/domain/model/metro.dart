import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'metro.freezed.dart';

part 'metro.g.dart';

Uuid uuid = const Uuid();

@freezed
class Metro with _$Metro {
  const factory Metro({
    required String id,
    required String line,
    required String name,
    required num? code,
    required double lat,
    required double lng,
    @Default(false) bool isTracking,
  }) = _Metro;

  factory Metro.fromJson(Map<String, Object?> json) => _$MetroFromJson(json);

  factory Metro.fromDataSource(Map<String, dynamic> json) {
    return Metro(
        id: uuid.v4(),
        line: json['line'],
        name: json['name'],
        code: json['code'] ?? null,
        lat: json['lat'],
        lng: json['lng'],
        isTracking: false);
  }

  factory Metro.fromSharedPref(Map<String, dynamic> json) {
    return Metro(
        id: json['id'],
        line: json['line'],
        name: json['name'],
        code: json['code'] ?? null,
        lat: json['lat'],
        lng: json['lng'],
        isTracking: false);
  }
}
