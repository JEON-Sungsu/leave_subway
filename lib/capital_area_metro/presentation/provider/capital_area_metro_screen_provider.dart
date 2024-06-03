import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/data/model/capital_area_model.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';
import 'package:leave_subway/capital_area_metro/data/repository/metro_list_repository_impl.dart';
import 'package:leave_subway/capital_area_metro/domain/repository/metro_list_repository.dart';
import 'package:leave_subway/common/data/local_data_manager.dart';

final capitalAreaMetroScreenProvider =
    StateNotifierProvider<CapitalAreaMetroScreenNotifier, CapitalAreaModel>(
  (ref) {
    final repository = ref.watch(metroListRepositoryProvider);
    final localDataManager = ref.watch(localDataManagerProvider);

    return CapitalAreaMetroScreenNotifier(
      repository: repository,
      localDataManager: localDataManager,
    );
  },
);

class CapitalAreaMetroScreenNotifier extends StateNotifier<CapitalAreaModel> {
  MetroListRepository repository;
  LocalDataManager localDataManager;

  CapitalAreaMetroScreenNotifier({
    required this.repository,
    required this.localDataManager,
  }) : super(CapitalAreaModel(isLoading: true)) {
    _initState();
  }

  void _initState() async {
    await localDataManager.init();
    List<Metro> destinations = await localDataManager.getSavedDestination();
    final metroData = await repository.getMetroList();
    final lines = metroData.map((e) => e.line).toSet();

    state = state.copyWith(
      lineNames: lines.toList(),
      wholeMetros: metroData,
      destinations: destinations,
      isLoading: false,
    );
  }

  void initWheelScroll() {
    setStationNames('01호선');
  }

  void setStationNames(String lineName) async {
    final sortedMetroByLine =
        state.wholeMetros.where((e) => e.line == lineName).toList();
    final selectedStation = sortedMetroByLine.first.name;

    state = state.copyWith(
      sortedMetroByLine: sortedMetroByLine,
      selectedStation: selectedStation,
    );
  }

  void setCurrentStation(String stationName) {
    state = state.copyWith(selectedStation: stationName);
  }

  void addDestinations(String stationName) async {
    final isExist =
        state.destinations.any((element) => element.name == stationName);
    if (isExist) {
      return;
    }

    final destination =
        state.sortedMetroByLine.where((e) => e.name == stationName).toList();
    state =
        state.copyWith(destinations: [...state.destinations, ...destination]);

    localDataManager.addDestination(destination.first);
  }

  void toggleTracking(String id) {
    final isOtherTracking =
        state.destinations.any((e) => e.isTracking == true && e.id != id);

    if (isOtherTracking) {
      state = state.copyWith(isOtherTracking: true);
      return;
    }

    final currentDestination = state.destinations.firstWhere((e) => e.id == id);

    state = state.copyWith(
      destinations: state.destinations
          .map((e) => e.id == id
              ? currentDestination.copyWith(isTracking: !e.isTracking)
              : e)
          .toList(),
      isOtherTracking: false,
    );
  }

  void removeDestination(String id) async {
    final pState = state.destinations.where((e) => e.id != id).toList();
    state = state.copyWith(destinations: pState);
    localDataManager.removeDestination(id);
  }
}
