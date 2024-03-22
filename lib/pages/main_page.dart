import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/home_page.dart';
import 'package:project_dangoing/pages/map_page.dart';
import 'package:project_dangoing/pages/my_page.dart';

import '../global/share_preference.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // 바텀 네비게이션 바 인덱스
  int _selectedIndex = 0;
  StoreController storeController = Get.find();

  final List<Widget> _navIndex = [HomePage(), MapPage(), MyPage()];

  @override
  void initState() {
    super.initState();
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller) {
      return Scaffold(
          body: _navIndex.elementAt(_selectedIndex),
          bottomNavigationBar: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BottomNavigationBar(
                    fixedColor: Colors.blue,
                    unselectedItemColor: Colors.blueGrey,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: '홈'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.public), label: '지도'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: '내정보'),
                    ],
                    currentIndex: _selectedIndex,
                    onTap: _onNavTapped,
                  )
                  // admob 추가하기
                ],
              ),
              controller.storeLoadState
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: CupertinoColors.systemGrey.withOpacity(0.3),
                          items: const [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home), label: '홈'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.public), label: '지도'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.person), label: '내정보'),
                          ]
                        )
                      ],
                    )
                  : SizedBox(),
            ],
          ));
    });
  }
}
