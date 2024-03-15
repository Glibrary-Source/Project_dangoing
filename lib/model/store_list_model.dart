

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_dangoing/vo/store_vo.dart';

class StoreListModel {
  List<StoreVo>? storeList;

  StoreListModel({this.storeList});

  StoreListModel.fromQuerySnapShor(QuerySnapshot querySnapshot) {
    storeList = <StoreVo>[];
    for (DocumentSnapshot item in querySnapshot.docs) {
      storeList!.add(StoreVo.fromDocumentSnapshot(item));
    }
    print(storeList);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (storeList != null) {
      data['storeList'] = storeList!.map((v) => v.toMap()).toList();
    }
    return data;
  }

}