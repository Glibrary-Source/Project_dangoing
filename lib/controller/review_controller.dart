import 'package:get/get.dart';
import 'package:project_dangoing/model/store_review_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../vo/review_vo.dart';

class ReviewController extends GetxController {
  final DangoFirebaseService dangoingFirebaseUserService =
      DangoFirebaseService();

  List<Map<String, ReviewVo>> storeReviewList = [];

  Future<void> getReviewData(String docId) async {
    try {
      StoreReviewModel storeReviewModel =
      await dangoingFirebaseUserService.getUserReview(docId);
      storeReviewList.clear();
      storeReviewList = storeReviewModel.reviewList ?? [];
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setReviewData(String docId, String uid, String nickname,
      num score, String main, String storeName) async {
    try {
      await dangoingFirebaseUserService.setUserReview(
          docId, uid, nickname, score, main, storeName);
      getReviewData(docId);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setReviewDataMyPage(String docId, String uid, String nickname,
      num score, String main, String storeName) async {
    try {
      await dangoingFirebaseUserService.setUserReviewMyPage(
          docId, uid, nickname, score, main, storeName);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> lostReviewData() async {
    storeReviewList = [];
  }
}
