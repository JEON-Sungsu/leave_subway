import 'package:go_router/go_router.dart';
import 'package:leave_subway/capital_area_metro/presentation/screen/capital_area_metro_screen.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/common/presentation/start_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return StartScreen();
      },
    ),
  ],
);
