
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';

abstract interface class MetroListRepository {
  Future<List<Metro>> getMetroList();
}