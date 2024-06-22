import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';

final PRIMARY_ELEVATED_STYLE = ElevatedButton.styleFrom(
    backgroundColor: PRIMARY_COLOR,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ));

final BASIC_PARAGRAPH_STYLE = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
