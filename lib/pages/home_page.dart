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
      return Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(" 🚗 내 주변 여행지 찾기",
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
                                  items: dropDownList
                                      .map<DropdownMenuItem<String>>(
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
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontStyleManager
                                        .getPrimarySecondFont()),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 16),
                          height: MediaQuery.sizeOf(context).height * 0.38,
                          child: ListView.builder(
                              itemCount: controller.storeHomeRandomList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecommendStoreListWidget(
                                    StoreVoList: controller.storeHomeRandomList,
                                    index: index);
                              }),
                        ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 16),
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
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontStyleManager
                                        .getPrimarySecondFont()),
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
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" 장소 별 모아보기",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily:
                                    fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryListMap.length,
                        itemBuilder: (context, index) {
                          return CategoryStoreListWidget(
                              index: index,
                              controller: controller,
                              categoryListData: categoryListMap);
                        }),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
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
        ],
      );
    });
  }
}
