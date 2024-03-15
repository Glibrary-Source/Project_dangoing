import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/recommend_store_list_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/utils/text_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StoreController storeController = Get.find();
  TextManager textManager = TextManager();

  @override
  void initState() {
    storeController.getStoreList();

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
                height: 250,
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
                    EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
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
                        : SizedBox(height: 260,
                          child: ListView.builder(
                              itemCount: controller.storeList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecommendStoreListWidget(
                                    controller: controller, index: index);
                              }),
                        ),
                    Text("카테고리",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'JosefinSans-Bold',
                            color: Colors.black)),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.orange),
                        )
                      ],
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

// @override
// Widget build(BuildContext context) {
//   return GetBuilder<StoreController>(builder: (controller) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//               flex: 3,
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 padding: EdgeInsets.only(left: 16),
//                 alignment: Alignment.centerLeft,
//                 decoration: BoxDecoration(color: Colors.black),
//                 child: Text(
//                   "반려동물과 친화적인\n장소를 찾아보세요",
//                   style: TextStyle(
//                       fontSize: 36,
//                       fontFamily: 'JosefinSans-Bold',
//                       color: Colors.white),
//                 ),
//               )),
//           Expanded(
//             flex: 7,
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               margin:
//                   EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(" 오늘은 어디갈까?",
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontFamily: 'JosefinSans-Bold',
//                           color: Colors.black)),
//                   controller.storeList == null
//                       ? SizedBox(height: 50)
//                       : Flexible(
//                           flex: 4,
//                           child: ListView.builder(
//                               itemCount: controller.storeList.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 return RecommendStoreListWidget(controller: controller, index: index);
//                               })
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text("카테고리",
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontFamily: 'JosefinSans-Bold',
//                           color: Colors.black)),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Flexible(
//                       flex: 2,
//                       child: Column(
//                         children: [
//                           Expanded(
//                               child: Container(
//                             decoration: BoxDecoration(color: Colors.orange),
//                           ))
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   });
// }
}
