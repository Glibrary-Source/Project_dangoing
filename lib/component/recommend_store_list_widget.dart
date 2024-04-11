import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/pages/store_list_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/text_manager.dart';

import '../pages/store_detail_page.dart';
import '../vo/store_vo.dart';

class RecommendStoreListWidget extends StatefulWidget {
  List<StoreVo> StoreVoList;
  final index;

  RecommendStoreListWidget(
      {super.key, required this.StoreVoList, required this.index});

  @override
  State<RecommendStoreListWidget> createState() =>
      _RecommendStoreListWidgetState();
}

class _RecommendStoreListWidgetState extends State<RecommendStoreListWidget> {
  TextManager textManager = TextManager();
  FontStyleManager fontStyleManager = FontStyleManager();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 4, top: 4, bottom: 8, right: 16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(()=> StoreListPage(), arguments: widget.StoreVoList[widget.index].CTGRY_THREE_NM);
                  },
                  child: Chip(
                    backgroundColor: dangoingPrimaryColor,
                    visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                    label: Text(
                      "#${widget.StoreVoList[widget.index].CTGRY_THREE_NM}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontStyleManager.suit,
                          fontWeight: fontStyleManager.weightHashTagChip,
                          color: dangoingMainColor,
                          height: 1.2
                      ),
                    ),
                    labelPadding: EdgeInsets.all(0),
                    padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                    side: BorderSide(
                      color: Colors.transparent
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => StoreDetailPage(),
                          arguments: widget.StoreVoList[widget.index].DOC_ID);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250,
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textManager.checkAddress(widget
                                .StoreVoList[widget.index].FCLTY_NM ??
                                ""),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.2,
                                fontSize: 22,
                                fontFamily: fontStyleManager.suit,
                                fontWeight: fontStyleManager.weightTitle
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textManager.checkAddress(widget.StoreVoList[widget.index].RDNMADR_NM ?? ""),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: fontStyleManager.suit,
                                fontWeight: fontStyleManager.weightSubTitle,
                                height: 1.2,
                                fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            textManager.checkOpenTime(widget.StoreVoList[widget.index].OPER_TIME ?? ""),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: fontStyleManager.suit,
                                fontWeight: fontStyleManager.weightSubTitle,
                                height: 1.2,
                                fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 25,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    textManager.checkParking(widget.StoreVoList[widget.index].PARKNG_POSBL_AT??"N"),
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
                                    textManager.checkInPlace(widget.StoreVoList[widget.index].IN_PLACE_ACP_POSBL_AT??"N"),
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
                            Row(
                              children: [
                                Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    "휴무: ${
                                        textManager.checkRestDay(widget
                                            .StoreVoList[widget.index]
                                            .RSTDE_GUID_CN ?? "N")
                                    }",
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
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
