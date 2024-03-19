
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/pages/store_detail_page.dart';

import '../utils/text_manager.dart';

class StoreListDetailWidget extends StatefulWidget {
  StoreController controller;
  final index;
  StoreListDetailWidget({super.key,required this.controller, required this.index});

  @override
  State<StoreListDetailWidget> createState() => _StoreListDetailWidgetState();
}

class _StoreListDetailWidgetState extends State<StoreListDetailWidget> {
  TextManager textManager = TextManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>StoreDetailPage(), arguments: widget.controller.categoryFilterList[widget.index].DOC_ID);
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        widget.controller.categoryFilterList[widget.index].FCLTY_NM ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "주소: ${widget.controller.categoryFilterList[widget.index].RDNMADR_NM ?? ""}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "휴일: ${textManager.checkRestDay(widget.controller.categoryFilterList[widget.index].RSTDE_GUID_CN ?? "")}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "영업시간: ${textManager.checkOpenTime(widget.controller.categoryFilterList[widget.index].OPER_TIME ?? "")}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "제한사항: ${widget.controller.categoryFilterList[widget.index].PET_LMTT_MTR_CN ?? ""}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        "주차: ${textManager.checkParking(widget.controller.categoryFilterList[widget.index].PARKNG_POSBL_AT ?? "")}",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
