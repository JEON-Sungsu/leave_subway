import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';
import 'package:leave_subway/common/const/ui_style.dart';

class PermissionAlert extends StatelessWidget {
  const PermissionAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      title: Text(
        '앱 접근 권한 안내',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            Text(
              '원활한 서비스 이용을 위해\n 권한 허용이 필요 합니다.',
              style: TextStyle(color: BODY_TEXT_COLOR),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '필수적 접근 권한',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '위치 액세스 권한',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text('목적지 도착 거리 계산'),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.notifications),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '푸쉬 알림 권한',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text('목적지 도착 예정 알림'),
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: PRIMARY_ELEVATED_STYLE,
            onPressed: () => Navigator.pop(context, 'Close'),
            child: Text(
              '확인',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
