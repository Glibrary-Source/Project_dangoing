import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';

import '../theme/colors.dart';
import '../utils/fontstyle_manager.dart';
import '../vo/review_vo.dart';

class MyReviewListWidget extends StatefulWidget {
  Map<String, ReviewVo> review;
  UserModel myModel;

  MyReviewListWidget({super.key, required this.review, required this.myModel});

  final FontStyleManager fontStyleManager = FontStyleManager();

  @override
  State<MyReviewListWidget> createState() => _MyReviewListWidgetState();
}

class _MyReviewListWidgetState extends State<MyReviewListWidget> {
  DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text(
                                "리뷰 삭제",
                              ),
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
                              content: Text("정말 리뷰를 삭제하시겠습니까?",),
                              actions: <Widget>[
                                Container(
                                  child: TextButton(
                                      onPressed: () async {
                                        // userController.deleteReview(widget.review.keys.first, widget.myModel.uid ?? "");
                                        userController.deleteReviewTest(widget.review.keys.first, widget.myModel.uid ?? "");
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "네",
                                      )),
                                ),
                                Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "아니오",
                                      )),
                                )
                              ],
                            );
                          }));
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${widget.review.values.first.store_name!}",
                          style: TextStyle(
                              fontSize: 18,
                              color: dangoingMainColor)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              "${widget.review.values.first.review_nickname!} 님",
                              style: TextStyle(
                                  fontSize: 18))),
                      Expanded(
                          child: Text(
                        "평가: ${widget.review.values.first.review_score!} 점",
                        style: TextStyle(
                            fontWeight: widget.fontStyleManager.weightSubTitle),
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(timeStampToDate(
                          widget.review.values.first.review_time!)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.review.values.first.review_main!),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String timeStampToDate(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formattedDate =
        "${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일";
    return formattedDate;
  }
}
