import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';

part 'capital_area_model.freezed.dart';

part 'capital_area_model.g.dart';

@freezed
class CapitalAreaModel with _$CapitalAreaModel{
  const factory CapitalAreaModel({
    @Default([]) List<String> lineNames,
    @Default([]) List<Metro> wholeMetros,
    @Default([]) List<Metro> sortedMetroByLine,
    @Default('') String selectedStation,
    @Default([]) List<Metro> destinations,
    @Default(false) bool isLoading,
    @Default(false) bool isOtherTracking,
  }) = _CapitalAreaModel;

  factory CapitalAreaModel.fromJson(Map<String, Object?> json) => _$CapitalAreaModelFromJson(json);
}