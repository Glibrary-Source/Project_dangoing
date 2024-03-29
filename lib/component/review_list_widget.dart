
import 'package:flutter/material.dart';

import '../vo/reviewVo.dart';

class ReviewListWidget extends StatefulWidget {
  Map<String, ReviewVo> review;
  ReviewListWidget({super.key, required this.review});

  @override
  State<ReviewListWidget> createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(widget.review.values.first.review_title!),
          Text(widget.review.values.first.review_nickname!),
          Text("${widget.review.values.first.review_score!}"),
          Text("${widget.review.values.first.review_time!}"),
          Text(widget.review.values.first.review_main!)
        ],
      ),
    );
  }
}
