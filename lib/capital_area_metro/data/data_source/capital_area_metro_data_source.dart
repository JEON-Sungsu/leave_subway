import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:leave_subway/capital_area_metro/data/model/metro.dart';

class CapitalAreaMetroDataSource {
  
  Future<List<Metro>> getMetroList() async {
    final stringData = await rootBundle.loadString('asset/json/station_coordinate.json');
    final jsonString = jsonDecode(stringData) as List;
    final List<Metro> metroList = jsonString.map((e) => Metro.fromJson(e)).toList();

    return metroList;
  }
}