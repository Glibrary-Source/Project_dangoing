import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/detail_page_info_widget.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/detail_info_list.dart';
import 'package:project_dangoing/utils/text_manager.dart';
import 'package:project_dangoing/vo/store_vo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({super.key});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  String docId = Get.arguments.toString();
  StoreController storeController = Get.find();
  StoreVo data = StoreVo();
  DateTime dt = DateTime.now();
  TextManager textManager = TextManager();
  late DetailInfoList detailInfoList;
  late List<String> infoList;

  @override
  void initState() {
    for (StoreVo store in storeController.storeList) {
      if (store.DOC_ID == docId) {
        data = store;
      }
      detailInfoList = DetailInfoList(textManager: textManager, data: data);
      infoList = detailInfoList.getInfoList();
    }

    super.initState();
  }

  launchKaKaoChannel(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      Get.snackbar('연결 실패', '어디어디로\n문의 부탁드립니다.',
          duration: Duration(seconds: 10), backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      data.FCLTY_NM ?? "없음",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: CupertinoColors.systemGrey),
                        Expanded(
                            child: Text(data.RDNMADR_NM ?? "",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: CupertinoColors.systemGrey))),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.systemGrey)),
                              Text("Today, ${dt.year}-${dt.month}-${dt.day}",
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: CupertinoColors.systemGrey)),
                              Text(textManager.checkOpenTime(data.OPER_TIME.toString()),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: (){
                                launchKaKaoChannel(data.HMPG_URL??"");
                              },
                              child: Text("공식 홈페이지로 이동"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.systemGrey2, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Icon(Icons.info_outline),
                            Text(" 가게 상세정보"),
                          ],
                        ),
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 12, right: 12, bottom: 8),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: infoList.length,

                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return DetailPageInfoWidget(info: infoList[index]);
                            })
                          )
                      ]),
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
}
