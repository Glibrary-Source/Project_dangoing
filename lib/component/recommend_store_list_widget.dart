import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_list_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/text_manager.dart';

import '../pages/store_detail_page.dart';
import '../vo/store_vo.dart';

class RecommendStoreListWidget extends StatefulWidget {
  final StoreController storeController;
  final StoreVo storeData;
  final int index;

  const RecommendStoreListWidget(
      {super.key,
      required this.index,
      required this.storeData,
      required this.storeController});

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
      margin: const EdgeInsets.only(left: 4, top: 4, bottom: 8, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 2),
          )
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const StoreListPage(),
                        arguments: widget.storeData.CTGRY_THREE_NM);
                  },
                  child: Chip(
                    backgroundColor: dangoingColorOrange50,
                    visualDensity:
                        const VisualDensity(horizontal: 0.0, vertical: -4),
                    label: Text(
                      "#${widget.storeData.CTGRY_THREE_NM}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontStyleManager.suit,
                          fontWeight: fontStyleManager.weightBold,
                          color: dangoingColorOrange500,
                          height: 1.2),
                    ),
                    labelPadding: const EdgeInsets.all(0),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, left: 8, right: 8),
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      widget.storeController
                          .setStoreDetailData(widget.storeData);
                      Get.to(() => const StoreDetailPage());
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              textManager.checkAddress(
                                  widget.storeData.FCLTY_NM ?? ""),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: 20,
                                  fontFamily: fontStyleManager.suit,
                                  fontWeight: fontStyleManager.weightBold,
                                  color: dangoingColorGray900),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 250,
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              textManager.checkAddress(
                                  widget.storeData.RDNMADR_NM ?? ""),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontStyleManager.suit,
                                fontWeight: fontStyleManager.weightRegular,
                                height: 1.2,
                                color: dangoingColorGray900,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 250,
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              textManager.checkOpenTime(
                                  widget.storeData.OPER_TIME ?? ""),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: fontStyleManager.suit,
                                  fontWeight: fontStyleManager.weightRegular,
                                  height: 1.2,
                                  color: dangoingColorGray900,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Chip(
                                    backgroundColor: dangoingColorGray100,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0.0, vertical: -4),
                                    label: Text(
                                      textManager.checkParking(
                                          widget.storeData.PARKNG_POSBL_AT ??
                                              "N"),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontStyleManager.suit,
                                          fontWeight: fontStyleManager.weightMedium,
                                          color: dangoingColorGray400),
                                    ),
                                    labelPadding: const EdgeInsets.all(0),
                                    padding: const EdgeInsets.only(
                                        right: 4, left: 4),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Chip(
                                    backgroundColor: dangoingColorGray100,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0.0, vertical: -4),
                                    label: Text(
                                      textManager.checkInPlace(widget.storeData
                                              .IN_PLACE_ACP_POSBL_AT ??
                                          "N"),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontStyleManager.suit,
                                          fontWeight: fontStyleManager.weightMedium,
                                          color: dangoingColorGray400),
                                    ),
                                    labelPadding: const EdgeInsets.all(0),
                                    padding: const EdgeInsets.only(
                                        right: 4, left: 4),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Chip(
                                    backgroundColor: dangoingColorGray100,
                                    visualDensity: const VisualDensity(
                                        horizontal: 0.0, vertical: -4),
                                    label: Text(
                                      "휴무: ${textManager.checkRestDay(widget.storeData.RSTDE_GUID_CN ?? "N")}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontStyleManager.suit,
                                          fontWeight: fontStyleManager.weightMedium,
                                          color: dangoingColorGray400),
                                    ),
                                    labelPadding: const EdgeInsets.all(0),
                                    padding: const EdgeInsets.only(
                                        right: 4, left: 4),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
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
