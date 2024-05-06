import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/store_list_detail_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';

import '../data/local_list_data.dart';
import '../global/share_preference.dart';
import '../theme/colors.dart';
import '../utils/fontstyle_manager.dart';

class StoreListPage extends StatefulWidget {
  const StoreListPage({super.key});

  @override
  State<StoreListPage> createState() => _StoreListPageState();
}

class _StoreListPageState extends State<StoreListPage> {
  final categoryName = Get.arguments.toString();

  StoreController storeController = Get.find();
  FontStyleManager fontStyleManager = FontStyleManager();
  LocalListData localListData = LocalListData();
  String? local;

  Future<void> _fetchData() async {
    await storeController.getStoreAndRandomList(local!, context);
    await storeController.getCategoryFilterList(categoryName);
    setState(() {
      storeController.setStoreLoadState(false);
    });
  }

  @override
  void initState() {
    storeController.getCategoryFilterList(categoryName);
    local = storeController.localName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller) {
      return Scaffold(
        body: Stack(children: [
          storeController.categoryFilterList.isEmpty
              ? const Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("목록이 비어있습니다.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28)),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.sizeOf(context).height*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back)),
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            "assets/images/location_indicator.png",
                                            width: 60,
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            "관심 지역 설정",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: fontStyleManager
                                                    .weightSubTitle),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: const Color(
                                                        0xffFFD2B0)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8)),
                                            width:
                                                MediaQuery.sizeOf(context)
                                                        .width *
                                                    0.9,
                                            child: DropdownButton(
                                              underline:
                                                  const SizedBox.shrink(),
                                              itemHeight: 50,
                                              icon: Image.asset(
                                                "assets/images/location_dropbox_arrow.png",
                                                width: 44,
                                                height: 44,
                                              ),
                                              isExpanded: true,
                                              items: localListData
                                                  .dropDownList
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((String
                                                      value) {
                                                return DropdownMenuItem<
                                                    String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {

                                                local = value ?? "서울특별시";
                                                prefs.setString(
                                                    "local", local!);
                                                storeController.setLocationName(
                                                  local!
                                                );

                                                storeController
                                                    .setStoreLoadState(
                                                    true);
                                                storeController
                                                    .getCategoryFilterList(
                                                    categoryName);

                                                Navigator.pop(context);
                                                _fetchData();
                                              },
                                              value: local,
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
                            highlightColor: dangoingColorOrange500,
                          )
                        ],
                      ),
                      const SizedBox(height: 40,),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: "  내 주변 ",
                          style: TextStyle(fontSize: 22, fontWeight: fontStyleManager.weightTitle)
                        ),
                        TextSpan(
                            text: categoryName,
                            style: TextStyle(fontSize: 22, color: dangoingColorOrange500, fontWeight: fontStyleManager.weightTitle)
                        ),
                        TextSpan(
                            text: " 찾기",
                            style: TextStyle(fontSize: 22, fontWeight: fontStyleManager.weightTitle)
                        ),
                      ])),
                      const SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: storeController.categoryFilterList.length,
                            padding: const EdgeInsets.only(top: 4),
                            itemBuilder: (context, index) {
                              return StoreListDetailWidget(
                                  controller: storeController, index: index);
                            }),
                      ),
                    ],
                  ),
                ),
          storeController.storeLoadState
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey.withOpacity(0.5),
                  ),
                  child: const Center(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator())),
                )
              : const SizedBox(),
        ]),
      );
    });
  }
}
