import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/data/model/capital_area_model.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';
import 'package:leave_subway/capital_area_metro/data/repository/metro_list_repository_impl.dart';
import 'package:leave_subway/capital_area_metro/domain/repository/metro_list_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _initState();
  }

  void _initState() async {
    List<Metro> destinations = [];
    final metroData = await repository.getMetroList();
    final lines = metroData.map((e) => e.line).toSet();
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('capitalDestination');
    final savedList = sharedPref.getStringList('capitalDestination');
    if (savedList != null) {
      final jsonString =
          savedList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      destinations = jsonString.map((e) => Metro.fromSharedPref(e)).toList();
    }

    state = state.copyWith(
        lineNames: lines.toList(),
        metros: metroData,
        destinations: destinations);
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
  }

  void addDestinations(String stationName) async {
    final isExist =
        state.destinations.any((element) => element.name == stationName);
    if (isExist) {
      return;
    }

    final destination =
        state.selectedMetros.where((e) => e.name == stationName).toList();
    state =
        state.copyWith(destinations: [...state.destinations, ...destination]);

    final sharedPref = await SharedPreferences.getInstance();
    final savedList = sharedPref.getStringList('capitalDestination');
    final String jsonStrings = jsonEncode(destination.first.toJson());

    if (savedList == null) {
      await sharedPref
          .setStringList('capitalDestination', <String>[jsonStrings]);
    } else {
      await sharedPref.setStringList(
          'capitalDestination', <String>[...savedList, jsonStrings]);
    }
  }

  void toggleTracking(String id) {
    final isOtherTracking =
        state.destinations.any((e) => e.isTracking == true && e.id != id);

    //TODO: 사용자에게 추적중인거 종료하고 켜라고 해야될듯 - 여기서 저거뭐야 스낵바 띄우는게 가능한가
    if (isOtherTracking) {
      return;
    }

    final currentDestination = state.destinations.firstWhere((e) => e.id == id);

    state = state.copyWith(
        destinations: state.destinations
            .map((e) => e.id == id
                ? currentDestination.copyWith(isTracking: !e.isTracking)
                : e)
            .toList());
  }

  void deleteDestination(String id) async {
    final pState = state.destinations.where((e) => e.id != id).toList();
    state = state.copyWith(destinations: pState);

    final sharedPref = await SharedPreferences.getInstance();
    final savedList = sharedPref.getStringList('capitalDestination');
    if (savedList != null) {
      final jsonString =
          savedList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      final newData = jsonString
          .where((element) => element['id'] != id)
          .toList()
          .map((e) => Metro.fromSharedPref(e))
          .toList()
          .map((e) => e.toJson())
          .toList();
      await sharedPref.setStringList(
          'capitalDestination', <String>[jsonEncode(newData)]);
    }
  }
}
