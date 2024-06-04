import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leave_subway/capital_area_metro/domain/model/metro.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:shimmer/shimmer.dart';

class DestinationListItem extends StatelessWidget {
  final String line;
  final String name;
  final bool isTracking;
  final VoidCallback onPressedDelete;
  final ValueChanged<bool> onValueChanged;

  DestinationListItem({
    super.key,
    required this.line,
    required this.name,
    required this.isTracking,
    required this.onPressedDelete,
    required this.onValueChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    line,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isTracking ? PRIMARY_COLOR : Colors.grey,
                    ),
                  ),
                ],
              ),
              if (isTracking)
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: PRIMARY_COLOR,
                    highlightColor: Colors.white,
                    child: const Text(
                      '추적중 ········',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
              else
                Spacer(),
              CupertinoSwitch(
                value: isTracking,
                onChanged: onValueChanged,
              ),
              IconButton(
                onPressed: onPressedDelete,
                icon: Icon(
                  Icons.close,
                  size: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
