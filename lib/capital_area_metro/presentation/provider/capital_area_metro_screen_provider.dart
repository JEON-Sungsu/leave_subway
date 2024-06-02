import 'dart:convert';

import 'package:flutter/material.dart';
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
      : super(CapitalAreaModel(isLoading: true)) {
    _initState();
  }

  void _initState() async {
    List<Metro> destinations = [];
    final metroData = await repository.getMetroList();
    final lines = metroData.map((e) => e.line).toSet();

    final sharedPref = await SharedPreferences.getInstance();
    // sharedPref.remove('capitalDestination');
    final savedList = sharedPref.getStringList('capitalDestination');
    if (savedList != null) {
      final jsonString =
          savedList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      destinations = jsonString.map((e) => Metro.fromSharedPref(e)).toList();
    }

    state = state.copyWith(
      lineNames: lines.toList(),
      wholeMetros: metroData,
      destinations: destinations,
      isLoading: false,
    );
  }

  void initializeScroll() {
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

  void deleteDestination(String id) async {
    final pState = state.destinations.where((e) => e.id != id).toList();
    state = state.copyWith(destinations: pState);

    final sharedPref = await SharedPreferences.getInstance();
    final List<String>? savedList =
        sharedPref.getStringList('capitalDestination');
    if (savedList != null) {
      final jsonString =
          savedList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      final newData = jsonString
          .where((metro) => metro['id'] != id)
          .map((e) => Metro.fromSharedPref(e).toJson())
          .toList();
      await sharedPref.setStringList('capitalDestination',
          <String>[...newData.map((e) => jsonEncode(e)).toList()]);
    }
  }
}
