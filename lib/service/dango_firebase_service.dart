import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/model/user_review_model.dart';

import '../model/store_list_model.dart';
import '../model/user_model.dart';
import '../vo/store_vo.dart';

FirebaseFirestore fireStore = FirebaseFirestore.instance;
CollectionReference store = fireStore.collection('pet_location_data');
CollectionReference storeReview = fireStore.collection('dangoing_review_db');
CollectionReference user = fireStore.collection('dangoing_user_db');

class DangoFirebaseService {

  Future<StoreListModel> getStoreList(String local) async {
    try {
      QuerySnapshot querySnapshot =
          await store.where("CTPRVN_NM", isEqualTo: local).get();
      return StoreListModel.fromQuerySnapShot(querySnapshot);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<StoreVo> getStoreDetail(String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await store.doc(docId).get();
      return StoreVo.fromDocumentSnapshot(documentSnapshot);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<UserReviewModel> getUserReview(String docId) async {
    try {
      DocumentSnapshot documentSnapshot = await storeReview.doc(docId).get();
      return UserReviewModel.fromDocumentSnapShot(documentSnapshot);
    } catch (error) {
      throw error;
    }
  }

  Future<void> setUserReview(String docId, String uid, String nickname, num score, String main, String storeName) async {
    try {
      final Map<String, dynamic> data = {};
      data['USER_REVIEW'] = {
        uid: {
          "review_nickname": nickname,
          "review_score": score,
          "review_main": main,
          "review_time": Timestamp.now(),
          "store_name": storeName,
        }
      };
      await storeReview.doc(docId).set(data, SetOptions(merge: true));
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteReview(String docId, String uid,) async {
    try {
      DocumentSnapshot documentSnapshot = await storeReview.doc(docId).get();

      Map<String, dynamic> storeOriginData = documentSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> storeOriginMap = storeOriginData["USER_REVIEW"] as Map<String, dynamic>;
      Map<String ,dynamic> storeNewMap = Map.from(storeOriginMap);

      storeNewMap.remove(uid);

      storeReview.doc(docId).update(
        {
          "USER_REVIEW": storeNewMap
        }
      );

    } catch(error) {
      throw error;
    }
  }

  Future<void> deleteUserReview(String docId, String uid) async {
    try {
      DocumentSnapshot userDocumentSnapshot = await user.doc(uid).get();

      Map<String, dynamic> userOriginData = userDocumentSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> userOriginMap = userOriginData["USER_REVIEW"] as Map<String, dynamic>;
      Map<String, dynamic> userNewMap = Map.from(userOriginMap);

      userNewMap.remove(docId);

      await user.doc(uid).update({
        "USER_REVIEW": userNewMap
      });

    } catch(error) {
      throw error;
    }
  }

  Future<void> setUserReviewMyPage(String docId, String uid, String nickname,
      num score, String main, String storeName) async {
    try {
      final Map<String, dynamic> data = {};
      data['USER_REVIEW'] = {
        docId: {
          "review_nickname": nickname,
          "review_score": score,
          "review_main": main,
          "review_time": Timestamp.now(),
          "store_name": storeName,
        }
      };
      user.doc(uid).set(data, SetOptions(merge: true));
    } catch (error) {
      throw error;
    }
  }
}
