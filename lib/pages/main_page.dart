import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/home_page.dart';
import 'package:project_dangoing/pages/map_page.dart';
import 'package:project_dangoing/pages/my_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

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
  UserController userController = Get.find();
  FontStyleManager fontStyleManager = FontStyleManager();

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
        body: Stack(children: [
          _navIndex.elementAt(_selectedIndex),
          controller.storeLoadState
              ? Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey.withOpacity(0.5),
            ),
            child: Center(
                child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator())),
          )
              : SizedBox(),
        ]),
        bottomNavigationBar: Stack(
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
          selectedLabelStyle: TextStyle(
              fontFamily: fontStyleManager.suit,
              fontWeight: FontWeight.w900),
          onTap: _onNavTapped,
        ),
        controller.storeLoadState
            ? BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor:
            CupertinoColors.systemGrey.withOpacity(0.3),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: '홈'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined), label: '지도'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: '내정보'),
            ])
            : SizedBox(),
        ],
      ));
    });
  }
}
