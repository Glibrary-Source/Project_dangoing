import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/fontstyle_manager.dart';

import '../vo/review_vo.dart';

class ReviewListWidget extends StatefulWidget {
  Map<String, ReviewVo> review;

  ReviewListWidget({super.key, required this.review});

  final FontStyleManager fontStyleManager = FontStyleManager();

  @override
  State<ReviewListWidget> createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                            "${widget.review.values.first.review_nickname!} 님",
                            style: const TextStyle(
                                fontSize: 18,
                                color: dangoingMainColor))),
                    Expanded(
                        child: Text(
                      "평가: ${widget.review.values.first.review_score!} 점",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
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
                const SizedBox(
                  height: 10,
                ),
                Text(widget.review.values.first.review_main!),
                const SizedBox(
                  height: 40,
                )
              ],
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
