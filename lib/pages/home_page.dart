import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/category_store_list_widget.dart';
import 'package:project_dangoing/component/recommend_store_list_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/category_list_data.dart';
import 'package:project_dangoing/data/local_list_data.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../global/share_preference.dart';
import '../utils/map_status_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoreController storeController = Get.find();
  CategoryListData categoryListData = CategoryListData();
  FontStyleManager fontStyleManager = FontStyleManager();
  CategoryListData categoryListMap = CategoryListData();
  LocalListData localListData = LocalListData();
  String? local;
  var lastPopTime;

  @override
  void initState() {
    local = storeController.localName;
    super.initState();
  }

  Future<void> _fetchData() async {
    await storeController.getStoreAndRandomList(local!, context);
    setState(() {
      storeController.setStoreLoadState(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        final now = DateTime.now();
        if (lastPopTime == null ||
            now.difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = now;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '뒤로 버튼을 한번더 누르면 앱이 종료됩니다.',
                style: TextStyle(
                  fontFamily: fontStyleManager.suit
                ),
              ),
            ),
          );
          return;
        } else {
          exit(0);
        }
      },
      child: GetBuilder<StoreController>(builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * 0.05,
                          left: 16,
                          right: 16),
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/logo/main_logo.png",
                                  height: 57,
                                  width: 148,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25),
                                          ),
                                        ),
                                        builder: (context) {
                                          return SizedBox(
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.35,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Image.asset("assets/images/location_indicator.png", width: 60, height: 15,),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "관심 지역 설정",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                    fontWeight: fontStyleManager.weightCategoryTitle
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                 Container(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      top: 10,
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffFFD2B0)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: DropdownButton(
                                                    underline: SizedBox.shrink(),
                                                    itemHeight: 50,
                                                    icon: Image.asset("assets/images/location_dropbox_arrow.png", width: 44,height: 44,),
                                                    isExpanded: true,
                                                    items: localListData
                                                        .dropDownList
                                                        .map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? value) {

                                                      local = value ?? "서울특별시";
                                                      prefs.setString(
                                                          "local", local!);
                                                      controller.setLocationName(
                                                        local!
                                                      );

                                                      controller.setStoreLoadState(true);

                                                      Navigator.pop(context);
                                                      _fetchData();
                                                    },
                                                    value: controller.localName,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: Image.asset(
                                    "assets/icons/map/icon_mylocation_map.png",
                                    width: 32,
                                    height: 32,
                                  ),
                                  highlightColor: dangoingMainColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, top: 32, bottom: 22),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(" 내 주변 장소 찾기",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: fontStyleManager.weightTitle,
                                      color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    controller.storeHomeRandomList.isEmpty
                        ? Card(
                            margin: EdgeInsets.only(right: 16),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              child: Center(
                                child: Text(
                                  "인터넷을 확인해주세요",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: fontStyleManager.suit,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(left: 16),
                            height: MediaQuery.sizeOf(context).height * 0.36,
                            child: ListView.builder(
                                itemCount:
                                    controller.storeHomeRandomList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return RecommendStoreListWidget(
                                      StoreVoList:
                                          controller.storeHomeRandomList,
                                      index: index);
                                }),
                          ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, top: 16, bottom: 22),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(" 요즘 뜨는 카페",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: fontStyleManager.suit,
                                      fontWeight: fontStyleManager.weightTitle,
                                      color: Colors.black)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    controller.storeHomeRandomCafeList.isEmpty
                        ? Card(
                            margin: EdgeInsets.only(right: 16),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              child: Center(
                                child: Text(
                                  "인터넷을 확인해주세요",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: fontStyleManager.suit,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(left: 16),
                            height: MediaQuery.sizeOf(context).height * 0.38,
                            child: ListView.builder(
                                itemCount:
                                    controller.storeHomeRandomCafeList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return RecommendStoreListWidget(
                                      StoreVoList:
                                          controller.storeHomeRandomCafeList,
                                      index: index);
                                }),
                          ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" 장소별 모아보기",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: fontStyleManager.suit,
                                  fontWeight: fontStyleManager.weightTitle,
                                  color: Colors.black)),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: MediaQuery.sizeOf(context).height * 0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryListMap.categoryMap.length,
                          itemBuilder: (context, index) {
                            return CategoryStoreListWidget(
                                index: index,
                                categoryListData: categoryListMap.categoryMap);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
