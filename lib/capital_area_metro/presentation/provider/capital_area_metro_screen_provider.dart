import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/data/model/capital_area_model.dart';
import 'package:leave_subway/capital_area_metro/data/repository/metro_list_repository_impl.dart';
import 'package:leave_subway/capital_area_metro/domain/repository/metro_list_repository.dart';

final capitalAreaMetroScreenProvider =
    StateNotifierProvider<CapitalAreaMetroScreenNotifier, CapitalAreaModel>(
        (ref) {
  final repository = ref.watch(metroListRepositoryProvider);

  return CapitalAreaMetroScreenNotifier(repository: repository);
});

class CapitalAreaMetroScreenNotifier extends StateNotifier<CapitalAreaModel> {
  MetroListRepository repository;

  CapitalAreaMetroScreenNotifier({required this.repository})
      : super(CapitalAreaModel()) {
    _setLineNames();
  }

  void _setLineNames() async {
    final metroData = await repository.getMetroList();
    final lines = metroData.map((e) => e.line).toSet();

    state = state.copyWith(lineNames: lines);
  }

  void setStationNames(String lineName) {
    final metroList = state.metros.where((e) => e.line == lineName).toList();
  }
}
