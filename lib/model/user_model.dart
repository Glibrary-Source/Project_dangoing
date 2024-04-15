import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/vo/user_vo.dart';

import '../vo/review_vo.dart';

class UserModel {
  String? email;
  String? nickname;
  String? uid;
  bool? change_counter;
  List<Map<String, ReviewVo>>? reviewList;

  UserModel({this.reviewList, this.email, this.nickname, this.uid, this.change_counter});

  UserModel.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    reviewList = <Map<String, ReviewVo>>[];
    Map<String, dynamic> data = {};

    if (documentSnapshot.data() == null) {
      data = {};
    } else {
      data = documentSnapshot.data() as Map<String, dynamic>;
    }

    email = data['email'];
    nickname = data['nickname'];
    uid = data['uid'];
    change_counter = data['change_counter'];

    if(data['USER_REVIEW'] == null) {
      reviewList = [];
    } else {
      data['USER_REVIEW'].forEach((reviewId, reviewData) {
        final review = ReviewVo(
          review_main: reviewData["review_main"],
          review_nickname: reviewData["review_nickname"],
          review_score: reviewData["review_score"],
          review_time: reviewData["review_time"],
          store_name: reviewData["store_name"]
        );
        reviewList!.add({reviewId : review});
      });
    }
  }
}