import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/review_list_widget.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/data/detail_info_list.dart';
import 'package:project_dangoing/pages/review_edit_page.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/text_manager.dart';
import 'package:project_dangoing/utils/user_share_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../vo/review_vo.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({super.key});

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  StoreController storeController = Get.find();
  ReviewController reviewController = Get.find();
  UserController userController = Get.find();
  FontStyleManager fontStyleManager = FontStyleManager();

  TextManager textManager = TextManager();

  TextEditingController reviewMainInputController = TextEditingController();

  String reviewMain = "";
  num reviewScore = 3.0;
  bool reviewEditVisible = false;

  final GlobalKey _widgetReviewKey = GlobalKey();
  final GlobalKey _widgetTopKey = GlobalKey();
  late DetailInfoList detailInfoList;

  @override
  void initState() {
    detailInfoList = DetailInfoList(
        textManager: textManager, data: storeController.detailStoreData);
    reviewController
        .getReviewData(storeController.detailStoreData.DOC_ID ?? "");

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
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    key: _widgetTopKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height * 0.05),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.sizeOf(context).height * 0.05),
                            child: IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () async {
                                share(
                                    storeController.detailStoreData.FCLTY_NM!,
                                    detailInfoList.getSharedText(),
                                    getUrlString(storeController
                                        .detailStoreData.HMPG_URL!));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Chip(
                        backgroundColor: dangoingPrimaryColor,
                        visualDensity:
                            const VisualDensity(horizontal: 0.0, vertical: -4),
                        label: Text(
                          "#${storeController.detailStoreData.CTGRY_THREE_NM}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: fontStyleManager.weightHashTagChip,
                            color: dangoingColorOrange500,
                          ),
                        ),
                        labelPadding: const EdgeInsets.all(0),
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 8, right: 8),
                        side: const BorderSide(color: Colors.transparent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(storeController.detailStoreData.FCLTY_NM ?? "없음",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: fontStyleManager.weightBold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          textManager.checkAddress(
                              storeController.detailStoreData.RDNMADR_NM ?? ""),
                          style: TextStyle(
                            height: 1.2,
                            fontWeight: fontStyleManager.weightRegular,
                            fontSize: 18,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            allowHalfRating: true,
                            initialRating:
                                ratingAverage(reviewController.storeReviewList),
                            minRating: 0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemBuilder: (context, _) => const Icon(
                              Icons.favorite,
                              color: dangoingColorOrange500,
                            ),
                            onRatingUpdate: (rating) {
                              return;
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            ratingAverage(reviewController.storeReviewList).toStringAsFixed(1),
                            style: TextStyle(
                                fontWeight: fontStyleManager.weightBold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Scrollable.ensureVisible(
                                    _widgetReviewKey.currentContext!,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    alignment: 0);
                              },
                              child: Text(
                                  "(리뷰 ${reviewController.storeReviewList.length}건)",
                                  style: const TextStyle(
                                      color: dangoingCategoryTitle,
                                      height: 1.1,
                                      decoration: TextDecoration.underline)))
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/detail/icon_date.png",
                                height: 32,
                                width: 32,
                              ),
                              Text(" 영업일",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: fontStyleManager.weightBold,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    " ${textManager.checkOpenTime(storeController.detailStoreData.OPER_TIME.toString())}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/detail/icon_clock.png",
                                height: 32,
                                width: 32,
                              ),
                              Text(" 휴일",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: fontStyleManager.weightBold,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    " ${textManager.checkOpenTime(storeController.detailStoreData.RSTDE_GUID_CN.toString())}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/detail/icon_store.png",
                                height: 32,
                                width: 32,
                              ),
                              Text(" 매장 상세정보",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: fontStyleManager.weightBold,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    " ${textManager.checkParking(storeController.detailStoreData.PARKNG_POSBL_AT.toString())}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
                                  ),
                                  labelPadding: const EdgeInsets.all(0),
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 4),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    textManager.checkInPlace(storeController
                                        .detailStoreData.IN_PLACE_ACP_POSBL_AT
                                        .toString()),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
                                  ),
                                  labelPadding: const EdgeInsets.all(0),
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 4),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    textManager.checkPetLimit(storeController
                                        .detailStoreData.PET_LMTT_MTR_CN
                                        .toString()),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
                                  ),
                                  labelPadding: const EdgeInsets.all(0),
                                  padding:
                                      const EdgeInsets.only(right: 4, left: 4),
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.04,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed:
                                storeController.detailStoreData.HMPG_URL != ""
                                    ? () async {
                                        launchHomeLink(storeController
                                                .detailStoreData.HMPG_URL ??
                                            "");
                                      }
                                    : null,
                            splashRadius: 1,
                            highlightColor: dangoingColorOrange500,
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            icon: Image.asset(
                              storeController.detailStoreData.HMPG_URL != ""
                                  ? "assets/button/store_web_go_button.png"
                                  : "assets/button/store_web_not_button.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (userController.myModel != null) {
                                if (checkExistReview(userController)) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("이미 리뷰를 작성하셨습니다")));
                                } else {
                                  Get.to(() => const ReviewEditPage(),
                                      transition: Transition.leftToRight);
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('로그인을 해주세요')));
                              }
                            },
                            splashRadius: 1,
                            highlightColor: dangoingColorOrange500,
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            icon: Image.asset(
                              "assets/button/review_edit_button.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Container(
                          key: _widgetReviewKey,
                          height: 2,
                          width: double.infinity,
                          color: dangoingColorGray200),
                      const SizedBox(
                        height:  20,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.95,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(text: "리뷰", style: TextStyle(
                                            fontSize: 18,
                                            color: dangoingColorGray900,
                                            fontWeight: FontWeight.w600)),
                                        TextSpan(text: " ${reviewController.storeReviewList.length}", style: const TextStyle(
                                            fontSize: 18,
                                            color: dangoingColorGray400,
                                            fontWeight: FontWeight.w600))
                                      ]
                                )),
                                IconButton(onPressed: (){
                                  Scrollable.ensureVisible(
                                      _widgetTopKey.currentContext!,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      alignment: 0);
                                }, icon: const Icon(Icons.keyboard_arrow_up_sharp))
                              ],
                            ),
                            reviewController.storeReviewList.isEmpty
                                ? const SizedBox(
                                    height: 200,
                                    child: Center(
                                        child: Text(
                                      "첫 리뷰를 남겨주세요!",
                                      style: TextStyle(fontSize: 22),
                                    )))
                                : SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.8,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.only(top: 32),
                                        itemCount: reviewController
                                            .storeReviewList.length,
                                        itemBuilder: (context, index) {
                                          return ReviewListWidget(
                                              review: reviewController
                                                  .storeReviewList[index]);
                                        }),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }

  double ratingAverage(List<Map<String, ReviewVo>> reviewList) {
    if (reviewList.isEmpty) {
      return 0.0;
    } else {
      num average = 0.0;
      for (var map in reviewList) {
        for (var review in map.values) {
          average = average + review.review_score!;
        }
      }
      return (average / reviewList.length);
    }
  }

  void launchHomeLink(String url) async {
    if (url == "") {
      return;
    }
    if (url.substring(0, 8) == "https://" || url.substring(0, 7) == "http://") {
      await launchUrlString(url);
    } else {
      await launchUrlString("https://$url");
    }
  }

  String getUrlString(String url) {
    if (url == "") {
      return "";
    }
    if (url.substring(0, 8) == "https://" || url.substring(0, 7) == "http://") {
      return url;
    } else {
      return "https://$url";
    }
  }

  bool checkExistReview(UserController userController) {
    for (var doc in reviewController.storeReviewList) {
      if (doc.keys.contains(userController.myModel!.uid!)) {
        return true;
      }
    }
    return false;
  }
}
