import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';

final metroListProvider =
    Provider<CapitalAreaMetroDataSource>((ref) => CapitalAreaMetroDataSource());

class CapitalAreaMetroDataSource {
  Future<List<Metro>> getMetroList() async {
    final stringData =
        await rootBundle.loadString('asset/json/station_coordinate.json');
    final jsonString = jsonDecode(stringData) as List;
    final List<Metro> metroList =
        jsonString.map((e) => Metro.fromDataSource(e)).toList();

    return metroList;
  }
}
