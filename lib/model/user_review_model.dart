
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/vo/reviewVo.dart';

class UserReviewModel {
  Map<String, Map<String, ReviewVo>>? reviewMap;

  UserReviewModel({this.reviewMap});

  UserReviewModel.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    reviewMap = <String, Map<String, ReviewVo>>{};
    reviewMap?['USER_REVIEW'] = ReviewVo.fromDocumentSnapshot(documentSnapshot) as Map<String, ReviewVo>;
  }
}