import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_subway/capital_area_metro/presentation/provider/capital_area_metro_screen_provider.dart';
import 'package:leave_subway/common/const/message.dart';
import 'package:leave_subway/common/data/local_storage_service.dart';
import 'package:leave_subway/common/permission/permission_manager.dart';
import 'package:leave_subway/common/router/router.dart';
import 'package:leave_subway/service/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharePreferenceProvider.overrideWithValue(pref),
      ],
      child: const _App(),
    ),
  );
}

class _App extends ConsumerStatefulWidget {
  const _App({super.key});

  @override
  ConsumerState<_App> createState() => _AppState();
}

class _AppState extends ConsumerState<_App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _onResumeState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
    );
  }

  void _onResumeState() async {
    await ref.read(permissionProvider.notifier).setPermissionStatus();
    if (ref.read(permissionProvider) != CombinedPermissionStatus.allGranted) {
      ref.read(locationServiceProvider.notifier).cancelLocationSubscription();
      ref
          .read(capitalAreaMetroScreenProvider.notifier)
          .toggleReset();
    }
  }
}
