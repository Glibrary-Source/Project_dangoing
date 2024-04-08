
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/home_page.dart';
import 'package:project_dangoing/pages/map_page.dart';
import 'package:project_dangoing/pages/my_page.dart';
import 'package:project_dangoing/theme/colors.dart';

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

  void _onNavTapped(int index) async {
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
                    unselectedItemColor: dangoingBlackColor,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined), label: '홈'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map_outlined), label: '지도'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline), label: '내정보'),
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
                                icon: Icon(Icons.home_outlined), label: '홈'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.map_outlined), label: '지도'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.person_outline), label: '내정보'),
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
