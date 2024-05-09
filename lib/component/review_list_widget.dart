import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            const SizedBox(width: 8,),
            Expanded(
                child: Text("${widget.review.values.first.review_nickname!} 님",
                    style: const TextStyle(
                        fontSize: 18, color: dangoingColorGray900,
                      fontWeight: FontWeight.w800
                    ),
                )),
            Expanded(
                child: Text(
                  timeStampToDate(widget.review.values.first.review_time!),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    color: dangoingColorGray400,
                    fontWeight: FontWeight.w500
                  ),
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.review.values.first.review_main!),
        const SizedBox(height: 40)
      ],
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
