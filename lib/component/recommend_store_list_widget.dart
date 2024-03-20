import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
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
    return GestureDetector(
      onTap: (){
        Get.to(()=>StoreDetailPage(), arguments: widget.controller.storeRandom[widget.index].DOC_ID);
      },
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 20),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      textManager.checkAddress(widget.controller.storeRandom[widget.index].FCLTY_NM ?? ""),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(height: 1.2,fontSize: 24,fontFamily: fontStyleManager.getPrimaryFont()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "주소: ${textManager.checkAddress(widget.controller.storeRandom[widget.index].RDNMADR_NM ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "카테고리: ${textManager.checkCategory(widget.controller.storeRandom[widget.index].CTGRY_THREE_NM ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "휴일: ${textManager.checkRestDay(widget.controller.storeRandom[widget.index].RSTDE_GUID_CN ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "영업시간: ${textManager.checkOpenTime(widget.controller.storeRandom[widget.index].OPER_TIME ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "제한사항: ${textManager.checkPetLimit(widget.controller.storeRandom[widget.index].PET_LMTT_MTR_CN ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "주차: ${textManager.checkParking(widget.controller.storeRandom[widget.index].PARKNG_POSBL_AT ?? "")}",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: fontStyleManager.getPrimarySecondFont(),height: 1.2,fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
