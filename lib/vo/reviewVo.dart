

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewVo {
  String? review_main;
  String? review_nickname;
  num? review_score;
  dynamic? review_time;
  String? review_title;

  ReviewVo({
    this.review_main,
    this.review_nickname,
    this.review_score,
    this.review_time,
    this.review_title
  });

  ReviewVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    review_main = documentSnapshot['review_main'];
    review_nickname = documentSnapshot['review_nickname'];
    review_score = documentSnapshot['review_score'];
    review_time = documentSnapshot['review_time'];
    review_title = documentSnapshot['review_title'];
  }


  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['review_main'] = review_main??"";
    data['review_nickname'] = review_nickname??"";
    data['review_score'] = review_score??"";
    data['review_time'] = review_time??false;
    data['review_title'] = review_title??"";
    return data;
  }
}