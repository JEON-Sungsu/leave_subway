import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:leave_subway/capital_area_metro/data/repository/metro_list_repository_impl.dart';
import 'package:leave_subway/capital_area_metro/domain/model/capital_area_model.dart';
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';
import 'package:leave_subway/capital_area_metro/domain/repository/metro_list_repository.dart';
import 'package:leave_subway/service/local_storage_service.dart';

final capitalAreaMetroScreenProvider =
    StateNotifierProvider<CapitalAreaMetroScreenNotifier, CapitalAreaModel>(
  (ref) {
    final repository = ref.watch(metroListRepositoryProvider);
    final localStorageService = ref.watch(localStorageServiceProvider);

    return CapitalAreaMetroScreenNotifier(
      repository: repository,
      localStorageService: localStorageService,
    );
  },
);

class CapitalAreaMetroScreenNotifier extends StateNotifier<CapitalAreaModel> {
  MetroListRepository repository;
  LocalStorageService localStorageService;

  CapitalAreaMetroScreenNotifier({
    required this.repository,
    required this.localStorageService,
  }) : super(CapitalAreaModel(isLoading: true)) {
    _initState();
  }

  void _initState() async {
    List<Metro> destinations = await localStorageService.getSavedDestination();
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
    setStationNames(lineName: '01호선');
  }

  void setStationNames({required String lineName}) async {
    final sortedMetroByLine = state.wholeMetros
        .where((e) => e.line == lineName)
        .sorted((a, b) => a.name.compareTo(b.name))
        .toList();
    final selectedStation = sortedMetroByLine.first.name;

    state = state.copyWith(
      sortedMetroByLine: sortedMetroByLine,
      selectedStation: selectedStation,
    );
  }

  void setCurrentStation({required String stationName}) {
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

    localStorageService.addDestination(destination.first);
  }

  void toggleTracking({required String id}) {
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

  void toggleReset() {
    state = state.copyWith(
      destinations:
          state.destinations.map((e) => e.copyWith(isTracking: false)).toList(),
      isOtherTracking: false,
    );
  }

  void removeDestination({required String id}) async {
    final pState = state.destinations.where((e) => e.id != id).toList();
    state = state.copyWith(destinations: pState);
    localStorageService.removeDestination(id);
  }
}
