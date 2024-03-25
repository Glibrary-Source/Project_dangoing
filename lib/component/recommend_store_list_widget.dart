import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_list_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/text_manager.dart';

import '../pages/store_detail_page.dart';

class RecommendStoreListWidget extends StatefulWidget {
  StoreController controller;
  final index;

  RecommendStoreListWidget(
      {super.key, required this.controller, required this.index});

  @override
  State<RecommendStoreListWidget> createState() =>
      _RecommendStoreListWidgetState();
}

class _RecommendStoreListWidgetState extends State<RecommendStoreListWidget> {
  TextManager textManager = TextManager();
  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5,),
        Padding(
          padding:
              EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(()=> StoreListPage(), arguments: widget.controller.storeHomeRandomList[widget.index].CTGRY_THREE_NM);
                },
                child: Chip(
                  backgroundColor: dangoingPrimaryColor,
                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                  label: Text(
                    "${widget.controller.storeHomeRandomList[widget.index].CTGRY_THREE_NM}",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: fontStyleManager.getPrimarySecondFont(),
                        fontWeight: FontWeight.bold,
                        color: dangoingChipBackGroundColor,
                        height: 1.2
                    ),
                  ),
                  labelPadding: EdgeInsets.all(0),
                  padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                  side: BorderSide(
                    color: Colors.transparent
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Get.to(() => StoreDetailPage(),
                      arguments: widget.controller.storeHomeRandomList[widget.index].DOC_ID);
                },
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        textManager.checkAddress(widget
                            .controller.storeHomeRandomList[widget.index].FCLTY_NM ??
                            ""),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 24,
                            fontFamily: fontStyleManager.getPrimaryFont()),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 250,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        textManager.checkAddress(widget.controller.storeHomeRandomList[widget.index].RDNMADR_NM ?? ""),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: fontStyleManager.getPrimarySecondFont(),
                            height: 1.2,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: 250,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        textManager.checkOpenTime(widget.controller.storeHomeRandomList[widget.index].OPER_TIME ?? ""),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: fontStyleManager.getPrimarySecondFont(),
                            height: 1.2,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Chip(
                          backgroundColor: Colors.transparent,
                          visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                          label: Text(
                            textManager.checkParking(widget.controller.storeHomeRandomList[widget.index].PARKNG_POSBL_AT??"N"),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: dangoingChipTextColor
                            ),
                          ),
                          labelPadding: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                          side: BorderSide(
                              color: Colors.transparent
                          ),
                        ),
                        Chip(
                          backgroundColor: Colors.transparent,
                          visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                          label: Text(
                            textManager.checkInPlace(widget.controller.storeHomeRandomList[widget.index].IN_PLACE_ACP_POSBL_AT??"N"),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: dangoingChipTextColor
                            ),
                          ),
                          labelPadding: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                          side: BorderSide(
                              color: Colors.transparent
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Chip(
                          backgroundColor: Colors.transparent,
                          visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                          label: Text(
                            "휴무: ${
                              textManager.checkRestDay(widget
                                      .controller
                                      .storeHomeRandomList[widget.index]
                                      .RSTDE_GUID_CN ??
                                  "N")
                            }",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: fontStyleManager.getPrimarySecondFont(),
                                fontWeight: FontWeight.bold,
                                color: dangoingChipTextColor
                            ),
                          ),
                          labelPadding: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                          side: BorderSide(
                              color: Colors.transparent
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
