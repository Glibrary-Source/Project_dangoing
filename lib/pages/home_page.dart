import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/category_store_list_widget.dart';
import 'package:project_dangoing/component/recommend_store_list_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/category_list_data.dart';
import 'package:project_dangoing/utils/text_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoreController storeController = Get.find();
  TextManager textManager = TextManager();
  CategoryListData categoryListData = CategoryListData();
  Map<String, String> categoryListMap = {};

  @override
  void initState() {
    storeController.getStoreList();
    categoryListMap = categoryListData.getCategoryMap();
    print("갯수 입니다 ${categoryListMap.length}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 190,
                padding: EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  "반려동물과 친화적인\n장소를 찾아보세요",
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: 'JosefinSans-Bold',
                      color: Colors.white),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, top: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" 오늘은 어디갈까?",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'JosefinSans-Bold',
                            color: Colors.black)),
                    controller.storeList == null
                        ? SizedBox(height: 50)
                        : SizedBox(height: 270,
                          child: ListView.builder(
                              itemCount: controller.storeList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecommendStoreListWidget(
                                    controller: controller, index: index);
                              }),
                        ),
                    Text(" 카테고리",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'JosefinSans-Bold',
                            color: Colors.black)),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryListMap.length,
                          itemBuilder: (context, index){
                            return CategoryStoreListWidget(index: index, categoryListData: categoryListMap);
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

}
