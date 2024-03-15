
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/store_list_model.dart';
import '../vo/store_vo.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference store = firestore.collection('pet_location_data');

class DangoFirebaseService {

  // 충청남도 store 정보만
  Future<StoreListModel> getStoreList() async {
    try {
      QuerySnapshot querySnapshot = await store.where("CTPRVN_NM", isEqualTo: "충청남도").get();
      return StoreListModel.fromQuerySnapShor(querySnapshot);
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
  
}