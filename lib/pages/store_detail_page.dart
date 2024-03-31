import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/detail_page_info_widget.dart';
import 'package:project_dangoing/component/review_list_widget.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/data/detail_info_list.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
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
  ReviewController reviewController = Get.find();
  FontStyleManager fontStyleManager = FontStyleManager();

  StoreVo data = StoreVo();
  DateTime dt = DateTime.now();

  TextManager textManager = TextManager();

  TextEditingController reviewTitleInputController = TextEditingController();
  TextEditingController reviewMainInputController = TextEditingController();
  String reviewTitle = "";
  String reviewMain = "";
  num reviewScore = 3.0;
  bool reviewEditVisible = false;

  final GlobalKey _widgetKey = GlobalKey();

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

    reviewController.getReviewData(docId);

    super.initState();
  }

  @override
  void dispose() {
    reviewController.lostReviewData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      return GetBuilder<ReviewController>(builder: (reviewController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(data.FCLTY_NM ?? "없음",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: fontStyleManager.getPrimaryFont())),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: CupertinoColors.systemGrey,
                          ),
                          Expanded(
                              child: Text(
                                  textManager.checkAddress(
                                      data.RDNMADR_NM ?? ""),
                                  style: TextStyle(
                                      height: 1.2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontFamily: fontStyleManager
                                          .getPrimarySecondFont(),
                                      color: CupertinoColors.systemGrey))),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date",
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont(),
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoColors.systemGrey)),
                                SizedBox(height: 5),
                                Text("Today, ${dt.year}-${dt.month}-${dt.day}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        height: 1.2,
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont()))
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
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont(),
                                        fontWeight: FontWeight.bold,
                                        height: 1.0,
                                        color: CupertinoColors.systemGrey)),
                                SizedBox(height: 5),
                                Text(
                                    textManager.checkOpenTime(
                                        data.OPER_TIME.toString()),
                                    style: TextStyle(
                                        fontSize: 18,
                                        height: 1.4,
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont()))
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: CupertinoColors.systemGrey2, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ExpansionTile(
                            initiallyExpanded: true,
                            title: Row(
                              children: [
                                Icon(Icons.info_outline),
                                Text(
                                  " 가게 상세정보",
                                  style: TextStyle(
                                      fontFamily:
                                          fontStyleManager.getPrimaryFont()),
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, bottom: 8),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: infoList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return DetailPageInfoWidget(
                                            info: infoList[index]);
                                      }))
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                launchHomeLink(data.HMPG_URL ?? "");
                              },
                              style: ButtonStyle(
                                backgroundColor: data.HMPG_URL == ""
                                    ? MaterialStateProperty.all(Colors.grey)
                                    : MaterialStateProperty.all(Colors.white),
                              ),
                              child: data.HMPG_URL == ""
                                  ? Text(
                                      "홈페이지 없음",
                                      style: TextStyle(
                                          fontFamily: fontStyleManager
                                              .getPrimarySecondFont(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  : Text(
                                      "공식 홈페이지로 이동",
                                      style: TextStyle(
                                          fontFamily: fontStyleManager
                                              .getPrimarySecondFont(),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "리뷰 보기",
                        style: TextStyle(
                            fontFamily: fontStyleManager.getPrimarySecondFont(),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      reviewEditVisible
                          ? Container(
                              width: double.infinity,
                              key: _widgetKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "  $reviewScore점 ",
                                    style: TextStyle(
                                        fontFamily: fontStyleManager
                                            .getPrimarySecondFont(),
                                        fontWeight: FontWeight.bold,
                                        color: dangoingMainColor),
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.pets,
                                      color: dangoingMainColor,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        reviewScore = rating;
                                      });
                                    },
                                  ),
                                ],
                              ))
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      reviewController.storeReviewList.isEmpty
                          ? SizedBox(
                              child: Text("데이터 없음"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  reviewController.storeReviewList.length,
                              itemBuilder: (context, index) {
                                return ReviewListWidget(
                                    review: reviewController
                                        .storeReviewList[index]);
                              }),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton:
              GetBuilder<UserController>(builder: (userController) {
            return FloatingActionButton(
                onPressed: () async {
                  if (userController.myInfo != null) {
                    Scrollable.ensureVisible(_widgetKey.currentContext!,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: 0);
                    reviewEditVisible = true;
                  } else {
                  }
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: dangoingMainColor,
                ),
                backgroundColor: dangoingPrimaryColor);
          }),
        );
      });
    });
  }

  launchHomeLink(String url) async {
    if (url == "") {
      return;
    }
    if (url.substring(0, 8) == "https://" || url.substring(0, 7) == "http://") {
      await launchUrlString(url);
    } else {
      await launchUrlString("https://$url");
    }
  }

  Future<void> writeReviewAndCloseDialog(userController) async {
    await reviewController.setReviewData(docId, userController.myInfo!.uid!,
        reviewTitle, userController.myInfo!.nickname!, reviewScore, reviewMain);
    reviewController.getReviewData(docId);
    reviewTitleInputController.clear();
    reviewMainInputController.clear();
    Navigator.of(context).pop();
  }
}
