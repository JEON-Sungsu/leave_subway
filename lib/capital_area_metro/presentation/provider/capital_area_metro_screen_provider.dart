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

    state = state.copyWith(lineNames: lines.toList(), metros: metroData);
  }

  void initializeScroll() {
    setStationNames('01호선');
  }

  void setStationNames(String lineName) async {
    final metroList = state.metros.where((e) => e.line == lineName).toList();
    final currentStation = metroList.first.name;
    state = state.copyWith(
      selectedMetros: metroList,
      currentStation: currentStation,
    );
  }

  void setCurrentStation(String stationName) {
    state = state.copyWith(currentStation: stationName);
    print(state.currentStation);
  }

  void addDestinations(String stationName) {
    final destination =
        state.selectedMetros.where((e) => e.name == stationName).toList();
    print(destination);
    state =
        state.copyWith(destinations: [...state.destinations, ...destination]);
  }
}
