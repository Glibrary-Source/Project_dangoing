

import 'package:cloud_firestore/cloud_firestore.dart';

import '../vo/review_vo.dart';

class StoreReviewModel {
  List<Map<String, ReviewVo>>? reviewList;

  StoreReviewModel({this.reviewList});

  StoreReviewModel.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    reviewList = <Map<String,ReviewVo>> [];
    Map<String, dynamic> data = {};

    if(documentSnapshot.data() == null) {
      data = {};
    } else {
      data = documentSnapshot.data() as Map<String, dynamic>;
    }

    data.forEach((key, value) {
      final temp = {
        key: ReviewVo(
          review_main: value["review_main"],
          review_nickname: value["review_nickname"],
          review_score: value["review_score"],
          review_time: value["review_time"],
        )
      };
      reviewList!.add(temp);
    });
  }
}