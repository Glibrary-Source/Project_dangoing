import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/category_store_list_widget.dart';
import 'package:project_dangoing/component/recommend_store_list_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/category_list_data.dart';
import 'package:project_dangoing/data/local_list_data.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../global/share_preference.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoreController storeController = Get.find();
  CategoryListData categoryListData = CategoryListData();
  FontStyleManager fontStyleManager = FontStyleManager();
  Map<String, String> categoryListMap = CategoryListData().getCategoryMap();
  List<String> dropDownList = LocalListData().getLocalList();
  String local = prefs.getString("local") ?? "서울특별시";

  Future<void> _fetchData() async {
    await storeController.getStoreAndRandomList(local, context);
    setState(() {
      storeController.setStoreLoadState(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller) {
      return Scaffold(
          body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/images/dangoing_logo.png",
                      height: 48,
                      width: 48,
                    ),
                    Image.asset(
                      "assets/images/dangoingTitle.png",
                      height: 64,
                      width: 64,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.only(left: 8),
                height: MediaQuery.sizeOf(context).height * 0.25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "반려동물과 여행할\n장소를 찾아보세요",
                      style: TextStyle(
                          fontSize: 36,
                          fontFamily: fontStyleManager.getPrimaryFont(),
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                height: MediaQuery.sizeOf(context).height * 0.48,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(" 내 주변 여행지 찾기",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily:
                                    fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: DropdownButton(
                              items: dropDownList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont()),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                local = value ?? "서울특별시";
                                prefs.setString("local", local);

                                setState(() {
                                  controller.setStoreLoadState(true);
                                });

                                _fetchData();
                              },
                              value: local,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.storeHomeRandomList == []
                        ? SizedBox(height: MediaQuery.sizeOf(context).height * 0.3)
                        : Expanded(
                            child: ListView.builder(
                                itemCount: controller.storeHomeRandomList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return RecommendStoreListWidget(
                                      controller: controller, index: index);
                                }),
                          ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 16),
                height: MediaQuery.sizeOf(context).height * 0.48,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(" 🧋요즘 뜨는 카페",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily:
                                fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    controller.storeHomeRandomList == []
                        ? SizedBox(height: MediaQuery.sizeOf(context).height * 0.3)
                        : Expanded(
                      child: ListView.builder(
                          itemCount: controller.categoryFilterList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return RecommendStoreListWidget(
                                controller: controller, index: index);
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" 장소 별 모아보기",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily:
                                    fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryListMap.length,
                          itemBuilder: (context, index) {
                            return CategoryStoreListWidget(
                                index: index,
                                controller: controller,
                                categoryListData: categoryListMap);
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
      ]));
    });
  }

// @override
// Widget build(BuildContext context) {
//   return GetBuilder<StoreController>(builder: (controller) {
//     return Scaffold(
//         body: Stack(children: [
//           Column(
//             children: [
//               Expanded(
//                   flex: 3,
//                   child: Container(
//                     decoration: BoxDecoration(color: Colors.black),
//                     padding: EdgeInsets.only(left: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "반려동물과 여행할\n장소를 찾아보세요",
//                           style: TextStyle(
//                               fontSize: 36,
//                               fontFamily: fontStyleManager.getPrimaryFont(),
//                               color: Colors.white),
//                         )
//                       ],
//                     ),
//                   )),
//               Expanded(
//                   flex: 6,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(" 오늘은 어디갈까?",
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     fontFamily: fontStyleManager
//                                         .getPrimarySecondFont(),
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                             Expanded(
//                               child: Container(
//                                 alignment: Alignment.topRight,
//                                 child: DropdownButton(
//                                   items: dropDownList
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: Text(
//                                             value,
//                                             style: TextStyle(
//                                                 fontFamily: fontStyleManager
//                                                     .getPrimarySecondFont()),
//                                           ),
//                                         );
//                                       }).toList(),
//                                   onChanged: (String? value) {
//                                     local = value ?? "서울특별시";
//                                     prefs.setString("local", local);
//
//                                     setState(() {
//                                       controller.setStoreLoadState(true);
//                                     });
//
//                                     _fetchData();
//                                   },
//                                   value: local,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         controller.storeRandom == []
//                             ? SizedBox(height: 50)
//                             : Expanded(
//                           child: ListView.builder(
//                               itemCount:
//                               controller.storeRandom.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return RecommendStoreListWidget(
//                                     controller: controller,
//                                     index: index);
//                               }),
//                         ),
//                       ],
//                     ),
//                   )),
//               Expanded(
//                   flex: 3,
//                   child: Container(
//                     padding: EdgeInsets.only(left: 16),
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(" 카테고리",
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     fontFamily: fontStyleManager
//                                         .getPrimarySecondFont(),
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 120,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: categoryListMap.length,
//                               itemBuilder: (context, index) {
//                                 return CategoryStoreListWidget(
//                                     index: index,
//                                     controller: controller,
//                                     categoryListData: categoryListMap);
//                               }),
//                         )
//                       ],
//                     ),
//                   )),
//             ],
//           ),
//           controller.storeLoadState
//               ? Container(width: double.infinity,height: double.infinity,
//                 decoration: BoxDecoration(color: CupertinoColors.systemGrey.withOpacity(0.5),),
//                 child: Center(child: Container(
//                     width: 50, height: 50, child: CircularProgressIndicator())),
//               )
//               : SizedBox(),
//     ]));
//   });
// }
}
