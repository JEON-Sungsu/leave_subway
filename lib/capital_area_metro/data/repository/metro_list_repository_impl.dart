import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/data/data_source/capital_area_metro_data_source.dart';
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';
import 'package:leave_subway/capital_area_metro/domain/repository/metro_list_repository.dart';

final metroListRepositoryProvider = Provider<MetroListRepositoryImpl>((ref) {
  final dataSource = ref.watch(metroListProvider);

  return MetroListRepositoryImpl(dataSource: dataSource);
});

class MetroListRepositoryImpl implements MetroListRepository {
  CapitalAreaMetroDataSource _dataSource;

  MetroListRepositoryImpl({
    required CapitalAreaMetroDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<Metro>> getMetroList() async {
    return await _dataSource.getMetroList();
  }
}