import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/store_list_detail_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  final categoryName = Get.arguments.toString();
  StoreController storeController = Get.find();

  @override
  void initState() {
    storeController.getCategoryFilterList(categoryName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller){
      return Scaffold(
        body: controller.categoryFilterList.isEmpty
        ? Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("목록이 비어있습니다.",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                ],
              ),
            ),
          ],
        )
        : ListView.builder(
            itemCount: controller.categoryFilterList.length,
            itemBuilder: (context, index) {
              return StoreListDetailWidget(controller: controller, index: index);
            }
        ),
      );
    });
  }
}
