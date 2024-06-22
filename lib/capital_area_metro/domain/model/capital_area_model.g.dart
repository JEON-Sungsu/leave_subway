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
      wholeMetros: (json['wholeMetros'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sortedMetroByLine: (json['sortedMetroByLine'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      selectedStation: json['selectedStation'] as String? ?? '',
      destinations: (json['destinations'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
      isOtherTracking: json['isOtherTracking'] as bool? ?? false,
    );

Map<String, dynamic> _$$CapitalAreaModelImplToJson(
        _$CapitalAreaModelImpl instance) =>
    <String, dynamic>{
      'lineNames': instance.lineNames,
      'wholeMetros': instance.wholeMetros,
      'sortedMetroByLine': instance.sortedMetroByLine,
      'selectedStation': instance.selectedStation,
      'destinations': instance.destinations,
      'isLoading': instance.isLoading,
      'isOtherTracking': instance.isOtherTracking,
    };
