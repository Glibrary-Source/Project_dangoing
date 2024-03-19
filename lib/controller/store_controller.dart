
import 'dart:math';
import 'package:get/get.dart';
import 'package:project_dangoing/model/store_list_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../vo/store_vo.dart';

class StoreController extends GetxController {

  final DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  List<StoreVo> storeList = [];
  List<StoreVo> storeRandom = [];
  List<StoreVo> categoryFilterList = [];
  StoreVo detailData = StoreVo();


  Future<void> getStoreList(String local) async {
    try {
      StoreListModel storeListModel = await dangoFirebaseService.getStoreList(local);
      storeList.clear();
      storeList.addAll(storeListModel.storeList!);
      update();
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<void> getRandomStoreList() async {
    try {
      storeRandom.clear();
      for (int i = 0; i < 11; i++) {
        storeRandom.add(storeList[Random().nextInt(storeList.length)]);
      }
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getStoreAndRandomList(String local) async {
    try {
      await getStoreList(local);
      await getRandomStoreList();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getCategoryFilterList(String category) async {
    try {
      categoryFilterList.clear();
      for (StoreVo store in storeList) {
        if(store.CTGRY_THREE_NM == category) {
          categoryFilterList.add(store);
        }
      }
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