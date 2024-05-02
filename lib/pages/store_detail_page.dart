import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/component/review_list_widget.dart';
import 'package:project_dangoing/controller/review_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/controller/user_controller.dart';
import 'package:project_dangoing/data/detail_info_list.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';
import 'package:project_dangoing/utils/text_manager.dart';
import 'package:project_dangoing/utils/user_share_manager.dart';
import 'package:project_dangoing/vo/store_vo.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../vo/review_vo.dart';

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
  ExpansionTileController reviewExpansionTileController =
      ExpansionTileController();

  StoreVo data = StoreVo();
  DateTime dt = DateTime.now();

  TextManager textManager = TextManager();

  TextEditingController reviewMainInputController = TextEditingController();
  String reviewMain = "";
  num reviewScore = 3.0;
  bool reviewEditVisible = false;

  final GlobalKey _widgetReviewKey = GlobalKey();
  final GlobalKey _widgetEditReviewKey = GlobalKey();

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
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
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
                                    data.FCLTY_NM!,
                                    detailInfoList.getSharedText(),
                                    getUrlString(data.HMPG_URL!));
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
                          "#${data.CTGRY_THREE_NM}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: fontStyleManager.weightHashTagChip,
                            color: dangoingMainColor,
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
                      Text(data.FCLTY_NM ?? "없음",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: fontStyleManager.weightTitle)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(textManager.checkAddress(data.RDNMADR_NM ?? ""),
                          style: TextStyle(
                            height: 1.2,
                            fontWeight: fontStyleManager.weightSubTitle,
                            fontSize: 18,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating:
                                ratingAverage(reviewController.storeReviewList),
                            minRating: 0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemBuilder: (context, _) => const Icon(
                              Icons.favorite,
                              color: dangoingMainColor,
                            ),
                            onRatingUpdate: (rating) {
                              return;
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${ratingAverage(reviewController.storeReviewList)}",
                            style: TextStyle(
                                fontWeight: fontStyleManager.weightTitle),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                reviewExpansionTileController.expand();
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
                                    fontWeight: fontStyleManager.weightTitle,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    " ${textManager.checkOpenTime(data.OPER_TIME.toString())}",
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
                                    fontWeight: fontStyleManager.weightTitle,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    " ${textManager.checkOpenTime(data.RSTDE_GUID_CN.toString())}",
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
                                    fontWeight: fontStyleManager.weightTitle,
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
                                    " ${textManager.checkParking(data.PARKNG_POSBL_AT.toString())}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
                                  ),
                                  labelPadding: const EdgeInsets.all(0),
                                  padding: const EdgeInsets.only(right: 4, left: 4),
                                  side: const BorderSide(color: Colors.transparent),
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
                                    textManager.checkInPlace(data.IN_PLACE_ACP_POSBL_AT.toString()),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
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
                          Row(
                            children: [
                              Flexible(
                                child: Chip(
                                  backgroundColor: dangoingChipBackgroundColor,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0.0, vertical: -4),
                                  label: Text(
                                    textManager.checkPetLimit(data.PET_LMTT_MTR_CN.toString()),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: dangoingChipTextColor),
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
                        ],
                      ),
                      SizedBox(
                        key: _widgetEditReviewKey,
                        height: MediaQuery.sizeOf(context).height * 0.04,
                      ),
                      data.HMPG_URL == ""
                          ? SizedBox(
                              width: double.infinity,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: null,
                                  splashRadius: 1,
                                  highlightColor: dangoingMainColor,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  icon: Image.asset(
                                    "assets/button/store_web_not_button.png",
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    launchHomeLink(data.HMPG_URL ?? "");
                                  },
                                  splashRadius: 1,
                                  highlightColor: dangoingMainColor,
                                  style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0))),
                                  icon: Image.asset(
                                    "assets/button/store_web_go_button.png",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: reviewEditVisible ? null : 0,
                        child: AnimatedOpacity(
                            opacity: reviewEditVisible ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(top: 8),
                                          child: const Text(
                                            "리뷰 작성",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: dangoingMainColor,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GetBuilder<UserController>(
                                                builder: (userController) {
                                              return IconButton(
                                                onPressed: () {
                                                  if (reviewMain == "") {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                "리뷰를 작성해주세요")));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: ((context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              "리뷰 작성",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      fontStyleManager
                                                                          .weightSubTitle),
                                                            ),
                                                            content: Text(
                                                              "리뷰를 남기시겠습니까?",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      fontStyleManager
                                                                          .weightSubTitle),
                                                            ),
                                                            surfaceTintColor:
                                                                Colors.white,
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            actions: <Widget>[
                                                              Container(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "취소",
                                                                          style: TextStyle(
                                                                              color: dangoingMainColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                              ),
                                                              Container(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                              editReview(
                                                                                  userController);
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "작성",
                                                                          style: TextStyle(
                                                                              color: dangoingMainColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                              )
                                                            ],
                                                          );
                                                        }));
                                                  }
                                                },
                                                icon: const Icon(Icons.edit),
                                                iconSize: 30,
                                                color: dangoingMainColor,
                                              );
                                            }),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      "$reviewScore점",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: dangoingMainColor),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding:
                                          const EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.pets,
                                        color: dangoingMainColor,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          reviewScore = rating;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          color: CupertinoColors.systemGrey5,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextField(
                                        controller: reviewMainInputController,
                                        maxLength: 400,
                                        maxLines: 10,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "리뷰 작성하기\n업주와 다른 사용자들이 상처받지 않도록 좋은 표현을 사용해주세요.유용한 Tip도 남겨주세요!",
                                            hintStyle: TextStyle(
                                                color:
                                                    CupertinoColors.systemGrey,
                                                fontWeight: FontWeight.bold)),
                                        onChanged: (value) {
                                          reviewMain = value;
                                          if (value.contains('\n')) {
                                            final lines = value.split("\n");
                                            if (lines.length > 10) {
                                              reviewMainInputController.text =
                                                  lines
                                                      .sublist(0, 10)
                                                      .join('\n');
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ))),
                      ),
                      Container(
                        key: _widgetReviewKey,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: CupertinoColors.systemGrey2, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(8))),
                        child: ExpansionTile(
                            shape: const Border(),
                            controller: reviewExpansionTileController,
                            onExpansionChanged: (value) async {
                              Future.delayed(const Duration(milliseconds: 300), () {
                                if (value) {
                                  Scrollable.ensureVisible(
                                      _widgetReviewKey.currentContext!,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      alignment: 0);
                                }
                              });
                            },
                            title: const Row(
                              children: [
                                Icon(Icons.reviews_outlined),
                                Text(
                                  " 리뷰 보기",
                                  style: TextStyle(height: 1),
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 8),
                                child: reviewController.storeReviewList.isEmpty
                                    ? const SizedBox(
                                        height: 200,
                                        child: Center(
                                            child: Text(
                                          "첫 리뷰를 남겨주세요!",
                                          style: TextStyle(fontSize: 22),
                                        )))
                                    : SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.8,
                                        child: ListView.builder(
                                            itemCount: reviewController
                                                .storeReviewList.length,
                                            itemBuilder: (context, index) {
                                              return ReviewListWidget(
                                                  review: reviewController
                                                      .storeReviewList[index]);
                                            }),
                                      ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      )
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
                  if (userController.myModel != null) {
                    setState(() {
                      reviewEditVisible = !reviewEditVisible;
                    });
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Scrollable.ensureVisible(
                          _widgetEditReviewKey.currentContext!,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: 0);
                    });
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('로그인을 해주세요')));
                  }
                },
                backgroundColor: dangoingPrimaryColor,
                child: const Icon(
                  Icons.edit_outlined,
                  color: dangoingMainColor,
                ));
          }),
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
      return average / reviewList.length;
    }
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

  editReview(UserController userController) {
    if (checkExistReview(userController)) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("이미 리뷰를 작성하셨습니다")));
    } else {
      reviewController.setReviewData(
          docId,
          userController.myModel!.uid!,
          userController.myModel!.nickname!,
          reviewScore,
          reviewMain,
          data.FCLTY_NM ?? "");

      reviewController.setReviewDataMyPage(
          docId,
          userController.myModel!.uid!,
          userController.myModel!.nickname!,
          reviewScore,
          reviewMain,
          data.FCLTY_NM ?? "");

      reviewMainInputController.clear();
      setState(() {
        reviewEditVisible = false;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("리뷰가 작성되었습니다.")));
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
