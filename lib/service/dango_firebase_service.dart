
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/store_list_model.dart';
import '../vo/reviewVo.dart';
import '../vo/store_vo.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference store = firestore.collection('pet_location_data');
CollectionReference storeReview = firestore.collection('user_review_db');

class DangoFirebaseService {

  // 충청남도 store 정보만
  Future<StoreListModel> getStoreList(String local) async {
    try {
      QuerySnapshot querySnapshot = await store.where("CTPRVN_NM", isEqualTo: local).get();
      return StoreListModel.fromQuerySnapShot(querySnapshot);
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<StoreVo> getStoreDetail(String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await store.doc(docId).get();
      return StoreVo.fromDocumentSnapshot(documentSnapshot);
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<ReviewVo> getUserReview(String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await storeReview.doc(docId).get();
      return ReviewVo.fromDocumentSnapshot(documentSnapshot);
    } catch(error) {
      throw error;
    }
  }

  Future<List<Map<String, ReviewVo>>> getUserReviewTest(String docId) async {
    List<Map<String,ReviewVo>> reviewList= [];
    DocumentSnapshot documentSnapshot = await storeReview.doc(docId).get();
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
        reviewList.add(temp);
      });
    }
    return reviewList;
  }
  
}