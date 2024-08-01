import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/common/const/ui_style.dart';
import 'package:leave_subway/common/presentation/default_layout.dart';

class UsageGuideScreen extends StatelessWidget {
  const UsageGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '이용 가이드',
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              style: BASIC_PARAGRAPH_STYLE,
              TextSpan(
                text: '· 본 서비스는, 지하철 목적지를 설정 하면, 설정된 목적지에 도착 하기 ',
                children: <TextSpan>[
                  TextSpan(
                    text: '3분 전, 1분 전, 도착 직후 ',
                    style: BASIC_PARAGRAPH_STYLE.copyWith(
                        fontWeight: FontWeight.w700, color: PRIMARY_COLOR),
                  ),
                  TextSpan(text: '푸쉬알림을 보내 사용자에게 하차 시기를 알려주는 서비스 입니다.'),
                ],
              ),
            ),
            SizedBox(height:16),
            Text.rich(
              style: BASIC_PARAGRAPH_STYLE,
              TextSpan(
                text: '· 알림의 간격인 3분 전, 1분 전은 ',
                children: <TextSpan>[
                  TextSpan(
                    text: '지하철 평균 속도인 33.7km/h 와 지하철 역간 평균 거리인 1km 를 기준',
                    style: BASIC_PARAGRAPH_STYLE.copyWith(
                        fontWeight: FontWeight.w700, color: PRIMARY_COLOR),
                  ),
                  TextSpan(text: '으로 계산 되어'),
                  TextSpan(text: '실제 도착 시간 과는 '),
                  TextSpan(
                    text: '차이가 ',
                    style: BASIC_PARAGRAPH_STYLE.copyWith(
                        fontWeight: FontWeight.w700, color: PRIMARY_COLOR),
                  ),
                  TextSpan(text: '있을 수 있습니다.'),
                ],
              ),
            ),
            SizedBox(height:16),
            Text(
              '· 지역별 지하철 화면 상단의 + 버튼을 눌러 자주가는 목적지를 추가할 수 있습니다.',
              style: BASIC_PARAGRAPH_STYLE,
            ),
            SizedBox(height:16),
            Text(
              '· 화면에 추가된 목적지의 스위치를 탭 하면 위치추적이 시작됩니다.',
              style: BASIC_PARAGRAPH_STYLE,
            ),
            SizedBox(height:16),
            Text(
              '· 목적지에 도착하면 자동으로 위치추적은 종료됩니다.',
              style: BASIC_PARAGRAPH_STYLE,
            ),
            SizedBox(height:16),
            Text(
              '· 두 곳 이상의 목적지 추적을 동시에 실행할 수 없습니다.',
              style: BASIC_PARAGRAPH_STYLE,
            ),
            SizedBox(height:16),
            Text(
              '· 서비스 사용중 문의사항이 있으면 anagma@naver.com으로 문의해주세요.',
              style: BASIC_PARAGRAPH_STYLE,
            ),
          ],
        ),
      ),
    );
  }
}
