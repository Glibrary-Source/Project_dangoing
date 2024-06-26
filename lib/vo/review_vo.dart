

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewVo {
  String? review_main;
  String? review_nickname;
  num? review_score;
  Timestamp? review_time;
  String? store_name;

  ReviewVo({
    this.review_main,
    this.review_nickname,
    this.review_score,
    this.review_time,
    this.store_name,
  });

  ReviewVo.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    review_main = documentSnapshot['review_main'];
    review_nickname = documentSnapshot['review_nickname'];
    review_score = documentSnapshot['review_score'];
    review_time = documentSnapshot['review_time'];
    store_name = documentSnapshot['store_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['review_main'] = review_main??"";
    data['review_nickname'] = review_nickname??"";
    data['review_score'] = review_score??"";
    data['review_time'] = review_time??false;
    data['store_name'] = store_name??"";
    return data;
  }

}