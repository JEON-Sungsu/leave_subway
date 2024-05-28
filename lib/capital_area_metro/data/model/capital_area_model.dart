import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';
import 'package:leave_subway/common/model/destination_list_model.dart';

part 'capital_area_model.freezed.dart';

part 'capital_area_model.g.dart';

@freezed
class CapitalAreaModel with _$CapitalAreaModel {
  const factory CapitalAreaModel({
    @Default({}) Set<String> lineNames,
    @Default([]) List<Metro> metros,
    @Default([]) List<DestinationListModel> destinations,
  }) = _CapitalAreaModel;

  factory CapitalAreaModel.fromJson(Map<String, Object?> json) => _$CapitalAreaModelFromJson(json);
}