import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_list_page.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

class CategoryStoreListWidget extends StatefulWidget {
  final int index;
  final Map<String, String> categoryListData;

  const CategoryStoreListWidget({super.key, required this.index,required this.categoryListData});

  @override
  State<CategoryStoreListWidget> createState() =>
      _CategoryStoreListWidgetState();
}

class _CategoryStoreListWidgetState extends State<CategoryStoreListWidget> {
  Map<String, String> data = {};
  List<String> categoryImgList = [];
  List<String> categoryTitleList = [];
  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  void initState() {
    data = widget.categoryListData;
    categoryImgList = data.values.toList();
    categoryTitleList = data.keys.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreListPage(), arguments: categoryTitleList[widget.index]);
      },
      child: Column(
        children: [
          Expanded(
              child: Card(
                margin: EdgeInsets.all(6),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Image.asset(
                    categoryImgList[widget.index],
                    fit: BoxFit.cover,
                          ),
                ),
              )),
          Text(categoryTitleList[widget.index], style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),),)
        ],
      ),
    );
  }
}
