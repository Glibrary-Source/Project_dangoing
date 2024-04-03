
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/model/store_list_model.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../pages/main_page.dart';
import '../vo/store_vo.dart';

class StoreController extends GetxController {

  final DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  List<StoreVo> storeList = [];
  List<StoreVo> storeHomeRandomList = [];
  List<StoreVo> storeHomeRandomCafeList = [];
  List<StoreVo> categoryFilterList = [];
  StoreVo detailData = StoreVo();
  bool storeLoadState = false;

  Future<void> getInitStoreList(String local) async {
    try {
      StoreListModel storeListModel = await dangoFirebaseService.getStoreList(local);
      storeList.clear();
      storeList.addAll(storeListModel.storeList!);
      update();
    } catch(error) {
      throw Exception(error);
    }
  }

  Future<void> getHomeRandomStoreList() async {
    try {
      storeHomeRandomList.clear();
      for (int i = 0; i < 10; i++) {
        storeHomeRandomList.add(storeList[Random().nextInt(storeList.length)]);
      }
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getHomeRandomCafeList() async {
    try {
      storeHomeRandomCafeList.clear();
      List<StoreVo> tempCategoryList = [];
      for(StoreVo store in storeList) {
        if(store.CTGRY_THREE_NM == "카페") {
          tempCategoryList.add(store);
        }
      }
      for (int i = 0; i < 10; i++) {
        storeHomeRandomCafeList.add(tempCategoryList[Random().nextInt(tempCategoryList.length)]);
      }
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getStoreAndRandomList(String local,BuildContext context) async {
    try {
      await getInitStoreList(local);
      getHomeRandomStoreList();
      getHomeRandomCafeList();
    } catch (error) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('인터넷 연결을 확인해주세요')));
      }
      storeLoadState = false;
      throw Exception(error);
    }
  }

  Future<void> getStoreAndRandomListSplash(String local,BuildContext context) async {
    try {
      await getInitStoreList(local);
      getHomeRandomStoreList();
      getHomeRandomCafeList();
    } catch (error) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('인터넷 연결을 확인해주세요')));
      }
      storeLoadState = false;
      Get.off(()=> MainPage());
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

  Future<void> setStoreLoadState(bool state) async{
    try{
      WidgetsBinding.instance.addPostFrameCallback((_){
        storeLoadState = state;
        update();
      });
    } catch(error) {
      throw Exception(error);
    }
  }
}