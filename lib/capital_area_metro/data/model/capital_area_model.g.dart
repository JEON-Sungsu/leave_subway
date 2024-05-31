// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capital_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CapitalAreaModelImpl _$$CapitalAreaModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CapitalAreaModelImpl(
      lineNames: (json['lineNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metros: (json['metros'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedMetros: (json['selectedMetros'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentStation: json['currentStation'] as String? ?? '',
      destinations: (json['destinations'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CapitalAreaModelImplToJson(
        _$CapitalAreaModelImpl instance) =>
    <String, dynamic>{
      'lineNames': instance.lineNames,
      'metros': instance.metros,
      'selectedMetros': instance.selectedMetros,
      'currentStation': instance.currentStation,
      'destinations': instance.destinations,
    };
