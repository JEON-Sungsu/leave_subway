// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MetroImpl _$$MetroImplFromJson(Map<String, dynamic> json) => _$MetroImpl(
      line: json['line'] as String,
      name: json['name'] as String,
      code: json['code'] as num?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$MetroImplToJson(_$MetroImpl instance) =>
    <String, dynamic>{
      'line': instance.line,
      'name': instance.name,
      'code': instance.code,
      'lat': instance.lat,
      'lng': instance.lng,
    };
