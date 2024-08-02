import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../controller/review_controller.dart';
import '../controller/store_controller.dart';
import '../controller/user_controller.dart';
import '../theme/colors.dart';

class ReviewEditPage extends StatefulWidget {
  const ReviewEditPage({super.key});

  @override
  State<ReviewEditPage> createState() => _ReviewEditPageState();
}

class _ReviewEditPageState extends State<ReviewEditPage> {
  String docId = Get.arguments.toString();
  StoreController storeController = Get.find();
  ReviewController reviewController = Get.find();
  TextEditingController reviewMainInputController = TextEditingController();
  FontStyleManager fontStyleManager = FontStyleManager();

  String reviewMain = "";
  num reviewScore = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16, right: 16, top: MediaQuery.of(context).padding.top + 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 44,
                      ),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.favorite,
                          color: dangoingColorOrange500,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            reviewScore = rating;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: dangoingColorGray100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: dangoingColorGray200),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: TextField(
                            controller: reviewMainInputController,
                            maxLength: 400,
                            maxLines: 10,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "나의 솔직한 리뷰와 유용한 팁을 남겨주세요!\n업주와 다른 사용자들이 상처받을 수 있는 과도한 비방은 삭제될 수 있습니다.",
                                hintStyle: TextStyle(
                                    color: CupertinoColors.systemGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            onChanged: (value) {
                              reviewMain = value;
                              if (value.contains('\n')) {
                                final lines = value.split("\n");
                                if (lines.length > 10) {
                                  reviewMainInputController.text =
                                      lines.sublist(0, 10).join('\n');
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32,),
                      SizedBox(
                        width: double.infinity,
                        child: GetBuilder<UserController>(
                          builder: (userController) {
                            return IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (reviewMain == "") {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("리뷰를 작성해주세요")));
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: const Text(
                                              "리뷰 작성",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                color: dangoingColorGray900
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            content: const Text(
                                              "후기를 남기시겠어요?",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8)),
                                            actions: <Widget>[
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        backgroundColor: dangoingColorOrange500
                                                      ),
                                                        onPressed: () async {
                                                          editReview(
                                                              userController);
                                                          Navigator.of(context)
                                                              .pop();

                                                          Navigator.of(context)
                                                          .pop();
                                                        },
                                                        child: const Text(
                                                          "작성",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(8)
                                                            ),
                                                            backgroundColor: dangoingColorGray100
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          "취소",
                                                          style: TextStyle(
                                                              color:
                                                              dangoingColorOrange500,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        }));
                                  }
                                },
                                splashRadius: 1,
                                style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0))),
                                icon: Image.asset("assets/button/review_edit_orange_button.png",
                                  fit: BoxFit.cover,
                                ));
                          }
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  editReview(UserController userController) {
    if (checkExistReview(userController)) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("이미 리뷰를 작성하셨습니다")));
    } else {
      reviewController.setReviewData(
          storeController.detailStoreData.DOC_ID ?? "",
          userController.myModel!.uid!,
          userController.myModel!.nickname!,
          reviewScore,
          reviewMain,
          storeController.detailStoreData.FCLTY_NM ?? "");

      reviewController.setReviewDataMyPage(
          storeController.detailStoreData.DOC_ID ?? "",
          userController.myModel!.uid!,
          userController.myModel!.nickname!,
          reviewScore,
          reviewMain,
          storeController.detailStoreData.FCLTY_NM ?? "");

      reviewMainInputController.clear();

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
