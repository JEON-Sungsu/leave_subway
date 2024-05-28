import 'package:freezed_annotation/freezed_annotation.dart';

part 'destination_list_model.freezed.dart';

part 'destination_list_model.g.dart';

@freezed
class DestinationListModel with _$DestinationListModel {
  const factory DestinationListModel({
    required String destination,
    required bool isTracking,
  }) = _DestinationListModel;

  factory DestinationListModel.fromJson(Map<String, Object?> json) => _$DestinationListModelFromJson(json);
}