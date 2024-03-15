
import 'package:get/get.dart';
import 'package:project_dangoing/model/store_list_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../vo/store_vo.dart';

class StoreController extends GetxController {

  final DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  List<StoreVo> storeList = [];

  Future<void> getStoreList() async {
    try {
      StoreListModel storeListModel = await dangoFirebaseService.getStoreList();
      storeList.clear();
      storeList.addAll(storeListModel.storeList!);
      update();
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<StoreVo> getStoreDetail(String docId) async {
    try {
      StoreVo storeDetail = await dangoFirebaseService.getStoreDetail(docId);
      return storeDetail;
    } catch(error) {
      throw Exception(error);
    }
  }


}