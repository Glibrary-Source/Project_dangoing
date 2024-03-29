
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/vo/reviewVo.dart';

class UserReviewModel {
  List<Map<String, ReviewVo>>? reviewList;

  UserReviewModel({this.reviewList});

  UserReviewModel.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    reviewList = <Map<String,ReviewVo>> [];
    final data = documentSnapshot.data() as Map<String, dynamic>;
    for(dynamic doc in data.values) {
      final reviewData = doc as Map<String, dynamic>;
      reviewData.forEach((key, value) {
        final temp = {
          key: ReviewVo(
              review_main: value["review_main"],
              review_nickname: value["review_nickname"],
              review_score: value["review_score"],
              review_time: value["review_time"],
              review_title: value["review_title"]
          )
        };
        reviewList!.add(temp);
      });
    }
  }

}