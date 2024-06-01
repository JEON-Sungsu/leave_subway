import 'package:flutter/material.dart';
import 'package:leave_subway/common/const/color.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final bool? isNested;
  final Widget? action;

  const DefaultLayout({
    super.key,
    required this.title,
    required this.child,
    this.isNested = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderAppBar(),
      body: child,
      drawer: isNested! ? null : CustomDrawer(),
    );
  }

  AppBar? renderAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      foregroundColor: Colors.black,
      actions: [
        if(action != null)
          action!
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final subtitleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, topPadding, 0, 16),
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '전체 메뉴',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Text(
                  '도시별 지하철',
                  style: subtitleStyle,
                ),
                SizedBox(height: 16),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    '· 수도권',
                    style: subtitleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 24),
                Text(
                  '어플리케이션 정보',
                  style: subtitleStyle,
                ),
                SizedBox(height: 16),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    '· 이용 가이드',
                    style: subtitleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    '· 개인정보 처리 방침',
                    style: subtitleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    '· 오픈소스 라이센스',
                    style: subtitleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
