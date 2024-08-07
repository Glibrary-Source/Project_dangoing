import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/pages/home_page.dart';
import 'package:project_dangoing/pages/map_page.dart';
import 'package:project_dangoing/pages/my_page.dart';
import 'package:project_dangoing/theme/colors.dart';

class MainPageTabbar extends StatefulWidget {
  const MainPageTabbar({super.key});

  @override
  State<MainPageTabbar> createState() => _MainPageTabbarState();
}

class _MainPageTabbarState extends State<MainPageTabbar>
    with SingleTickerProviderStateMixin {
  StoreController storeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          animationDuration: Duration.zero,
          child: GetBuilder<UserController>(builder: (userController) {
            return GetBuilder<StoreController>(builder: (storeController) {
              return Scaffold(
                  body: Stack(children: [
                    const TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [HomePage(), MapPage(), MyPage()]),
                    storeController.storeLoadState
                        ? Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  CupertinoColors.systemGrey.withOpacity(0.5),
                            ),
                            child: const Center(
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator())),
                          )
                        : const SizedBox(),
                  ]),
                  bottomNavigationBar: Stack(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.08,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(top: BorderSide(width: 2, color: dangoingColorGray100))
                        ),
                        child: const TabBar(
                          //tab 하단 indicator size -> .label = label의 길이
                          //tab 하단 indicator size -> .tab = tab의 길이
                          indicatorSize: TabBarIndicatorSize.label,
                          //tab 하단 indicator color
                          indicatorColor: Colors.transparent,
                          //tab 하단 indicator weight
                          indicatorWeight: 1,
                          //label color
                          labelColor: dangoingColorOrange500,
                          //unselected label color
                          unselectedLabelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                          tabs: [
                            Tab(
                              icon: Icon(Icons.home_outlined),
                              iconMargin: EdgeInsets.all(4),
                              text: "홈",
                            ),
                            Tab(
                              icon: Icon(Icons.map_outlined),
                              iconMargin: EdgeInsets.all(4),
                              text: '지도',
                            ),
                            Tab(
                              icon: Icon(Icons.person_outline),
                              iconMargin: EdgeInsets.all(4),
                              text: '내정보',
                            ),
                          ],
                        ),
                      ),
                      storeController.storeLoadState
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.08,
                              decoration: BoxDecoration(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.5),
                              ),
                            )
                          : const SizedBox(),
                      userController.signInIndicator
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.08,
                              decoration: BoxDecoration(
                                color:
                                    CupertinoColors.systemGrey.withOpacity(0.5),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ));
            });
          })),
    );
  }
}
