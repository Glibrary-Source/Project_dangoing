import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_detail_page.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../theme/colors.dart';
import '../utils/ad_manager.dart';
import '../utils/text_manager.dart';
import 'full_width_banner_ad_widget.dart';

class StoreListDetailWidget extends StatefulWidget {
  StoreController controller;
  final index;

  StoreListDetailWidget(
      {super.key, required this.controller, required this.index});

  @override
  State<StoreListDetailWidget> createState() => _StoreListDetailWidgetState();
}

class _StoreListDetailWidgetState extends State<StoreListDetailWidget> {
  TextManager textManager = TextManager();
  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => StoreDetailPage(),
              arguments:
                  widget.controller.categoryFilterList[widget.index].DOC_ID);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 36, bottom: 36, left: 16, right: 16),
              margin: EdgeInsets.only(bottom: 20, left: 2, right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0,2),
                  )
                ],
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "${widget.controller.categoryFilterList[widget.index].FCLTY_NM ?? ""}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.4, fontSize: 24, fontWeight: fontStyleManager.weightTitle),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "${textManager.checkAddress(widget.controller.categoryFilterList[widget.index].RDNMADR_NM ?? "")}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.4, fontSize: 18,fontWeight: fontStyleManager.weightSubTitle),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "${textManager.checkOpenTime(widget.controller.categoryFilterList[widget.index].OPER_TIME ?? "")}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.4, fontSize: 18, fontWeight: fontStyleManager.weightSubTitle),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          Chip(
                            backgroundColor: dangoingChipBackgroundColor,
                            visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                            label: Text(
                              "${textManager.checkParking(widget.controller.categoryFilterList[widget.index].PARKNG_POSBL_AT ?? "")}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: fontStyleManager.suit,
                                  color: dangoingChipTextColor
                              ),
                            ),
                            labelPadding: EdgeInsets.all(0),
                            padding: EdgeInsets.only(right: 4, left: 4),
                            side: BorderSide(
                                color: Colors.transparent
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                          ),
                          SizedBox(width: 8,),
                          Chip(
                            backgroundColor: dangoingChipBackgroundColor,
                            visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                            label: Text(
                              "${textManager.checkInPlace(widget.controller.categoryFilterList[widget.index].IN_PLACE_ACP_POSBL_AT ?? "")}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: fontStyleManager.suit,
                                  color: dangoingChipTextColor
                              ),
                            ),
                            labelPadding: EdgeInsets.all(0),
                            padding: EdgeInsets.only(right: 4, left: 4),
                            side: BorderSide(
                                color: Colors.transparent
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2,),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Chip(
                        backgroundColor: dangoingChipBackgroundColor,
                        visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                        label: Text(
                          "${textManager.checkRestDay(widget.controller.categoryFilterList[widget.index].RSTDE_GUID_CN ?? "")}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: fontStyleManager.suit,
                              color: dangoingChipTextColor
                          ),
                        ),
                        labelPadding: EdgeInsets.all(0),
                        padding: EdgeInsets.only(right: 4, left: 4),
                        side: BorderSide(
                            color: Colors.transparent
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
