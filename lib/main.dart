import 'package:flutter/material.dart';
import 'package:leave_subway/common/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '내리라',
      home: SplashScreen(),
    );
  }
}