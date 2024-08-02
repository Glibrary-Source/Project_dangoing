import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_detail_page.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../theme/colors.dart';
import '../utils/text_manager.dart';
import '../vo/store_vo.dart';

class StoreListDetailWidget extends StatefulWidget {
  final StoreVo storeData;
  final StoreController storeController;

  const StoreListDetailWidget(
      {super.key, required this.storeData, required this.storeController});

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
        widget.storeController.setStoreDetailData(widget.storeData);
        Get.to(() => const StoreDetailPage());
      },
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 36, bottom: 36, left: 16, right: 16),
            margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
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
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      widget.storeData.FCLTY_NM ??
                          "",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.4,
                          color: dangoingColorGray900,
                          fontSize: 20,
                          fontWeight: fontStyleManager.weightBold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      textManager.checkAddress(widget.storeData.RDNMADR_NM ??
                          ""),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.4,
                          color: dangoingColorGray900,
                          fontSize: 16,
                          fontWeight: fontStyleManager.weightRegular),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      textManager.checkOpenTime(widget.storeData.OPER_TIME ??
                          ""),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.4,
                          color: dangoingColorGray900,
                          fontSize: 16,
                          fontWeight: fontStyleManager.weightRegular),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: [
                        Chip(
                          backgroundColor: dangoingColorGray100,
                          visualDensity: const VisualDensity(
                              horizontal: 0.0, vertical: -4),
                          label: Text(
                            textManager.checkParking(widget
                                    .storeData
                                    .PARKNG_POSBL_AT ??
                                ""),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: fontStyleManager.suit,
                                color: dangoingColorGray400),
                          ),
                          labelPadding: const EdgeInsets.all(0),
                          padding: const EdgeInsets.only(right: 4, left: 4),
                          side: const BorderSide(color: Colors.transparent),
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
                            textManager.checkInPlace(widget
                                    .storeData
                                    .IN_PLACE_ACP_POSBL_AT ??
                                ""),
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: fontStyleManager.suit,
                                color: dangoingColorGray400),
                          ),
                          labelPadding: const EdgeInsets.all(0),
                          padding: const EdgeInsets.only(right: 4, left: 4),
                          side: const BorderSide(color: Colors.transparent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Chip(
                      backgroundColor: dangoingColorGray100,
                      visualDensity:
                          const VisualDensity(horizontal: 0.0, vertical: -4),
                      label: Text(
                        textManager.checkRestDay(widget
                                .storeData
                                .RSTDE_GUID_CN ??
                            ""),
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: fontStyleManager.suit,
                            color: dangoingColorGray400),
                      ),
                      labelPadding: const EdgeInsets.all(0),
                      padding: const EdgeInsets.only(right: 4, left: 4),
                      side: const BorderSide(color: Colors.transparent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
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
