import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_dangoing/model/user_model.dart';
import 'package:project_dangoing/service/firebase_auth_service.dart';

import '../theme/colors.dart';
import '../utils/fontstyle_manager.dart';
import '../vo/review_vo.dart';

class MyReviewListWidget extends StatefulWidget {
  final Map<String, ReviewVo> review;
  final UserModel myModel;

  MyReviewListWidget({super.key, required this.review, required this.myModel});

  final FontStyleManager fontStyleManager = FontStyleManager();

  @override
  State<MyReviewListWidget> createState() => _MyReviewListWidgetState();
}

class _MyReviewListWidgetState extends State<MyReviewListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: dangoingColorGray200),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                widget.review.values.first.store_name!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: dangoingColorOrange500),
                maxLines: 1,
              )),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text(
                              "리뷰 삭제",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: dangoingColorGray900),
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                              "정말 후기를 삭제하시겠어요?",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            actions: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor:
                                                dangoingColorOrange500),
                                        onPressed: () async {
                                          userController.deleteReview(
                                              widget.review.keys.first,
                                              widget.myModel.uid ?? "");
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "삭제하기",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor:
                                                dangoingColorGray100),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "취소",
                                          style: TextStyle(
                                              color: dangoingColorOrange500,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          );
                        }));
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          RatingBar.builder(
            ignoreGestures: true,
            initialRating: widget.review.values.first.review_score!.toDouble(),
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
            height: 12,
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/user_profile.png",
                height: 40,
                width: 40,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Text(
                "${widget.review.values.first.review_nickname!} 님",
                style: const TextStyle(
                    fontSize: 18,
                    color: dangoingColorGray900,
                    fontWeight: FontWeight.w800),
              )),
              Expanded(
                  child: Text(
                timeStampToDate(widget.review.values.first.review_time!),
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 12,
                    color: dangoingColorGray400,
                    fontWeight: FontWeight.w500),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(widget.review.values.first.review_main!),
        ],
      ),
    );
  }

  String timeStampToDate(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    var month = dateTime.month;
    var day = dateTime.day;
    var monthString = "";
    var dayString = "";
    if (month < 10) {
      monthString = "0$month";
    } else {
      monthString = "$month";
    }
    if (day < 10) {
      dayString = "0$day";
    } else {
      dayString = "$day";
    }

    final formattedDate = "${dateTime.year}-$monthString-$dayString";

    return formattedDate;
  }
}
