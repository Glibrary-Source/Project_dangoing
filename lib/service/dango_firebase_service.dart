
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/model/user_review_model.dart';

import '../model/store_list_model.dart';
import '../vo/store_vo.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference store = fireStore.collection('pet_location_data');
CollectionReference storeReview = fireStore.collection('dangoing_review_db');
CollectionReference user = fireStore.collection('dangoing_user_db');

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

  Future<UserReviewModel> getUserReview(String docId) async {
    try{
      DocumentSnapshot documentSnapshot = await storeReview.doc(docId).get();
      return UserReviewModel.fromDocumentSnapShot(documentSnapshot);
    } catch(error) {
      throw error;
    }
  }

  Future<void> setUserReview(String docId, String uid, String nickname, num score, String main) async {
    try {
      final Map<String, dynamic> data = {};
      data['USER_REVIEW'] = {
        uid: {
              "review_nickname": nickname,
              "review_score": score,
              "review_main": main,
              "review_time": Timestamp.now()
        }
      };
      storeReview.doc(docId).set(data, SetOptions(merge: true));
    } catch(error) {
      throw error;
    }
  }

  Future<void> setUserReviewMyPage(String docId, String uid, String nickname, num score, String main) async {
    try {
      final Map<String, dynamic> data = {};
      data['USER_REVIEW'] = {
        docId: {
          "review_nickname": nickname,
          "review_score": score,
          "review_main": main,
          "review_time": Timestamp.now()
        }
      };
      user.doc(uid).set(data, SetOptions(merge: true));
    } catch(error) {
      throw error;
    }
  }

}