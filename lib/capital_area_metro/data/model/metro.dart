import 'package:freezed_annotation/freezed_annotation.dart';

part 'metro.freezed.dart';

part 'metro.g.dart';

@freezed
class Metro with _$Metro {
  const factory Metro({
    required String line,
    required String name,
    required num? code,
    required double lat,
    required double lng
  }) = _Metro;

  factory Metro.fromJson(Map<String, Object?> json) => _$MetroFromJson(json);
}