import 'package:flutter/material.dart';
import 'package:project_dangoing/data/category_list_data.dart';

class CategoryStoreListWidget extends StatefulWidget {
  final index;
  Map<String, String> categoryListData;

  CategoryStoreListWidget(
      {super.key, required this.index, required this.categoryListData});

  @override
  State<CategoryStoreListWidget> createState() =>
      _CategoryStoreListWidgetState();
}

class _CategoryStoreListWidgetState extends State<CategoryStoreListWidget> {
  Map<String, String> data = {};
  List<String> categoryImgList = [];
  List<String> categoryTitleList = [];

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
        Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  categoryImgList[widget.index],
                  fit: BoxFit.cover,
                        ),
              ),
            )),
        Text(categoryTitleList[widget.index])
      ],
    );
  }
}
