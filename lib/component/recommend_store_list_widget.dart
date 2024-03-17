

import 'package:flutter/material.dart';
import 'package:project_dangoing/utils/text_manager.dart';

class RecommendStoreListWidget extends StatefulWidget {

  final controller;
  final index;

  const RecommendStoreListWidget({super.key, required this.controller, required this.index});

  @override
  State<RecommendStoreListWidget> createState() => _RecommendStoreListWidgetState();
}

class _RecommendStoreListWidgetState extends State<RecommendStoreListWidget> {

  TextManager textManager = TextManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.only(left:8, right: 8, top: 24, bottom: 20),
            child: Column(
              children: [
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(widget.
                    controller.storeList[widget.index]
                        .FCLTY_NM ??
                        "",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "주소: ${widget.controller.storeList[widget.index].LNM_ADDR ?? ""}",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "휴일: ${textManager.checkRestDay(widget.controller.storeList[widget.index].RSTDE_GUID_CN ?? "")}",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "영업시간: ${textManager.checkOpenTime(widget.controller.storeList[widget.index].OPER_TIME ?? "")}",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "제한사항: ${widget.controller.storeList[widget.index].PET_LMTT_MTR_CN ?? ""}",
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "주차: ${textManager.checkParking(widget.controller.storeList[widget.index].PARKNG_POSBL_AT ?? "")}",
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
    );
  }
}
