import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_list_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

class CategoryStoreListWidget extends StatefulWidget {
  final int index;
  final Map<String, String> categoryListData;

  const CategoryStoreListWidget(
      {super.key, required this.index, required this.categoryListData});

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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => StoreListPage(), arguments: categoryTitleList[widget.index]);
          },
          child: Container(
              margin: EdgeInsets.only(right: 6, left: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 2),
                  )
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                categoryImgList[widget.index],
                width: 52,
                height: 52,
              )),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          categoryTitleList[widget.index],
          style: TextStyle(
            fontWeight: fontStyleManager.weightCategoryTitle,
            color: dangoingCategoryTitle
          ),
        )
      ],
    );
  }
}
