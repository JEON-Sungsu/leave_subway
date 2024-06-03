import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/domain/model/capital_area_model.dart';
import 'package:leave_subway/capital_area_metro/presentation/provider/capital_area_metro_screen_provider.dart';
import 'package:leave_subway/common/const/color.dart';

class DestinationBottomSheet extends ConsumerStatefulWidget {
  const DestinationBottomSheet({
    super.key,
  });

  @override
  ConsumerState<DestinationBottomSheet> createState() =>
      _DestinationBottomSheetState();
}

class _DestinationBottomSheetState
    extends ConsumerState<DestinationBottomSheet> {
  Timer? _timer;
  final FixedExtentScrollController _stationScrollController = FixedExtentScrollController(initialItem: 0);

  void _onScroll(int value, Function(int) onChangeValue) async {
    _timer?.cancel();

    _timer = Timer(
      const Duration(milliseconds: 500),
      () async {
        onChangeValue(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(capitalAreaMetroScreenProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (state is CapitalAreaModel)
    return Container(
      height: deviceHeight * 0.5,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: 0,
                    child: SizedBox(
                      width: 72,
                    ),
                  ),
                  Center(
                    child: Text(
                      '목적지 설정',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      ref
                          .read(capitalAreaMetroScreenProvider.notifier)
                          .addDestinations(state.selectedStation);
                      Navigator.pop(context);
                    },
                    child: Text(
                      '등록하기',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              _renderWheelScroll(
                width: deviceWidth,
                height: deviceHeight,
                listItem: state.lineNames,
                callBack: (int index) {
                  ref
                      .read(capitalAreaMetroScreenProvider.notifier)
                      .setStationNames(state.lineNames[index]);
                  _stationScrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
              ),
              _renderWheelScroll(
                width: deviceWidth,
                height: deviceHeight,
                controller: _stationScrollController,
                listItem: state.sortedMetroByLine.map((e) => e.name).toList(),
                callBack: (int index) {
                  final stationName = state.sortedMetroByLine[index].name;
                  ref
                      .read(capitalAreaMetroScreenProvider.notifier)
                      .setCurrentStation(stationName);
                },
              ),
            ],
          ),
        ],
      ),
    );

    return Center(child: Text('오류가 발생 하였습니다.'));
  }

  SizedBox _renderWheelScroll(
      {required double width,
      required double height,
      FixedExtentScrollController? controller,
      required List<String> listItem,
      required ValueChanged<int> callBack}) {
    return SizedBox(
      width: width * 0.5,
      height: height * 0.3,
      child: ListWheelScrollView(
        itemExtent: 30,
        controller: controller,
        onSelectedItemChanged: (int index) {
          _onScroll(index, callBack);
        },
        squeeze: 0.7,
        perspective: 0.00001,
        useMagnifier: true,
        overAndUnderCenterOpacity: 0.7,
        magnification: 1.2,
        physics: ScrollPhysics(),
        children: listItem.map((e) => Text(e)).toList(),
      ),
    );
  }
}
