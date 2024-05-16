import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/home/presentation/destination_set_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class OnboardingScreen extends StatefulWidget {
  final PermissionStatus _locationPermission;
  final PermissionStatus _notificationPermission;
  final ServiceStatus _locationServiceStatus;

  const OnboardingScreen({
    super.key,
    required PermissionStatus locationPermission,
    required PermissionStatus notificationPermission,
    required ServiceStatus locationServiceStatus,
  })  : _locationPermission = locationPermission,
        _notificationPermission = notificationPermission,
        _locationServiceStatus = locationServiceStatus;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _onTextWidgetRendered() {
    setState(() {
      _isButtonVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Lottie.asset(
              'asset/json/splash_metro.json',
            ),
            const SizedBox(height: 16),
            _TextAnimation(onRendered: _onTextWidgetRendered),
            const Spacer(),
            AnimatedOpacity(
              opacity: _isButtonVisible ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0), //borderRadius
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => DestinationSetScreen(
                          locationPermission: widget._locationPermission,
                          notificationPermission: widget._notificationPermission,
                          locationServiceStatus: widget._locationServiceStatus,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                height:
                    Platform.isIOS ? MediaQuery.of(context).padding.bottom : 20)
          ],
        ),
      ),
    );
  }
}

class _TextAnimation extends StatefulWidget {
  final VoidCallback onRendered;

  const _TextAnimation({super.key, required this.onRendered});

  @override
  State<_TextAnimation> createState() => _TextAnimationState();
}

class _TextAnimationState extends State<_TextAnimation> {
  final List<bool> _isVisible = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    _animationDelaySet();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _isVisible[0] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            '지하철을 타고 가는 당신',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: _isVisible[1] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            '내릴 때가 됐는데..',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: _isVisible[2] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            '도대체 여기가 어디쯤 인지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: _isVisible[3] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            '답답한 경험 한 번쯤 있으셨 나요?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: _isVisible[4] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: const Text(
            '그럴땐..',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 32),
        AnimatedOpacity(
          opacity: _isVisible[5] ? 1 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: 200.0,
            height: 70.0,
            child: Shimmer.fromColors(
              baseColor: PRIMARY_COLOR,
              highlightColor: Colors.white,
              child: const Text(
                '내리라',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _animationDelaySet() async {
    int delay = 300;
    for (var i = 0; i < _isVisible.length; i++) {
      await Future.delayed(Duration(milliseconds: delay), () {
        setState(() {
          _isVisible[i] = true;
        });
        delay += 300;
      });
      if (i == _isVisible.length - 1) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => widget.onRendered());
      }
    }
  }
}
