import 'package:go_router/go_router.dart';
import 'package:leave_subway/capital_area_metro/presentation/screen/capital_area_metro_screen.dart';
import 'package:leave_subway/common/presentation/onboarding_screen.dart';
import 'package:leave_subway/common/presentation/start_screen.dart';
import 'package:leave_subway/infomation/presentation/usage_guide_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return StartScreen();
      },
    ),
    GoRoute(
      path: '/capital',
      builder: (context, state) {
        return CapitalAreaMetroScreen();
      },
    ),
    GoRoute(
      path: '/usage',
      builder: (context, state) {
        return UsageGuideScreen();
      },
    ),
  ],
);
