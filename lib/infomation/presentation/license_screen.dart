import 'package:flutter/material.dart';
import 'package:leave_subway/common/presentation/default_layout.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '오픈소스 라이센스 정보',
      child: Center(
        child: Text('오소오소'),
      ),
    );
  }
}
