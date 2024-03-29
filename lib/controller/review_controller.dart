import 'package:get/get.dart';
import 'package:project_dangoing/model/user_review_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../vo/reviewVo.dart';

class ReviewController extends GetxController {
  final DangoFirebaseService dangoingFirebaseUserService =
      DangoFirebaseService();

  List<Map<String, ReviewVo>> storeReviewList = [];

  Future<void> getReviewData(String docId) async {
    try {
      UserReviewModel userReviewModel =
          await dangoingFirebaseUserService.getUserReview(docId);
      storeReviewList.clear();
      storeReviewList = userReviewModel.reviewList!;
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setReviewData(String docId, String uid, String title, String nickname, num score, String main) async {
    try {
      await dangoingFirebaseUserService.setUserReview(docId, uid, title, nickname, score, main);
      getReviewData(docId);
    } catch (error) {
      throw Exception(error);
    }
  }
}
