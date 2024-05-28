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
              .toSet() ??
          const {},
      metros: (json['metros'] as List<dynamic>?)
              ?.map((e) => Metro.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      destinations: (json['destinations'] as List<dynamic>?)
              ?.map((e) =>
                  DestinationListModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CapitalAreaModelImplToJson(
        _$CapitalAreaModelImpl instance) =>
    <String, dynamic>{
      'lineNames': instance.lineNames.toList(),
      'metros': instance.metros,
      'destinations': instance.destinations,
    };
