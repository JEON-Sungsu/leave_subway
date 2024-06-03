import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localDataManagerProvider = Provider((ref) => LocalDataManager());

class LocalDataManager {
  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<List<Metro>> getSavedDestination() async {
    List<Metro> destinations = [];
    final List<String>? savedDestinations = _loadDestinations();
    if (savedDestinations != null) {
      final jsonString =
      savedDestinations.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      destinations = jsonString.map((e) => Metro.fromSharedPref(e)).toList();
    }

    return destinations;
  }

  void addDestination(Metro destination) async {
    final List<String>? savedDestinations = _loadDestinations();
    final String jsonStrings = jsonEncode(destination.toJson());

    if (savedDestinations == null) {
      await _pref
          .setStringList('capitalDestination', <String>[jsonStrings]);
    } else {
      await _pref.setStringList(
          'capitalDestination', <String>[...savedDestinations, jsonStrings]);
    }
  }

  void removeDestination(String id) async {
    final List<String>? savedDestinations = _loadDestinations();

    if (savedDestinations != null) {
      final jsonString =
      savedDestinations.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      final newData = jsonString
          .where((metro) => metro['id'] != id)
          .map((e) => Metro.fromSharedPref(e).toJson())
          .toList();
      await _pref.setStringList('capitalDestination',
          <String>[...newData.map((e) => jsonEncode(e)).toList()]);
    }
  }

  List<String>? _loadDestinations() {
     final List<String>? destinations = _pref.getStringList('capitalDestination');

     return destinations;
  }
}
