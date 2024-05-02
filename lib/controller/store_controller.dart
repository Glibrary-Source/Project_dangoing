import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/model/store_list_model.dart';
import 'package:project_dangoing/pages/main_page_tabbar.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';

import '../global/share_preference.dart';
import '../vo/store_vo.dart';

class StoreController extends GetxController {
  final DangoFirebaseService dangoFirebaseService = DangoFirebaseService();

  List<StoreVo> storeList = [];
  List<StoreVo> storeHomeRandomList = [];
  List<StoreVo> storeHomeRandomCafeList = [];
  List<StoreVo> categoryFilterList = [];
  String localName = prefs.getString("local") ?? "서울특별시";
  StoreVo detailData = StoreVo();
  bool storeLoadState = false;

  Future<void> getInitStoreList(String local) async {
    try {
      StoreListModel storeListModel =
          await dangoFirebaseService.getStoreList(local);
      storeList.clear();
      storeList.addAll(storeListModel.storeList!);
      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getHomeRandomStoreList() async {
    try {
      storeHomeRandomList.clear();
      List<String> categoryList = ["미술관", "박물관", "문예회관", "펜션", "여행지"];

      //추천할때 필요
      // List<int> numList = [];

      List<StoreVo> tempList = [];

      for (StoreVo store in storeList) {
        if (categoryList.contains(store.CTGRY_THREE_NM)) {
          tempList.add(store);
        }
      }

      if(tempList.length >= 10) {
        for ( int num = 0; num <= 9; num++){
          storeHomeRandomList.add(tempList[num]);
        }
      } else {
        storeHomeRandomList.addAll(tempList);
      }

      // 램덤 불안정함 리스트가 10개 이하면 무한루프에 빠짐
      // while (storeHomeRandomList.length <= 9) {
      //   var number = Random().nextInt(tempList.length);
      //
      //   if (!numList.contains(number)) {
      //     storeHomeRandomList.add(tempList[number]);
      //     numList.add(number);
      //   }
      // }
      // numList.clear();

      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getHomeRandomCafeList() async {
    try {
      storeHomeRandomCafeList.clear();

      List<int> numList = [];
      List<StoreVo> tempCategoryList = [];

      for (StoreVo store in storeList) {
        if (store.CTGRY_THREE_NM == "카페") {
          tempCategoryList.add(store);
        }
      }

      if(tempCategoryList.length >= 10) {
        for ( int num = 0; num <= 9; num++){
          storeHomeRandomCafeList.add(tempCategoryList[num]);
        }
      } else {
        storeHomeRandomCafeList.addAll(tempCategoryList);
      }

      // 램덤 불안정함 리스트가 10개 이하면 무한루프에 빠짐
      // int listLength = tempCategoryList.length;
      //
      // if(tempCategoryList.length <= 10) {
      //   storeHomeRandomCafeList.addAll(tempCategoryList);
      // } else {
      //   while (storeHomeRandomCafeList.length <= listLength) {
      //     var number = Random().nextInt(tempCategoryList.length);
      //
      //     if(!numList.contains(number)) {
      //       storeHomeRandomCafeList.add(tempCategoryList[number]);
      //     }
      //   }
      // }

      update();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getStoreAndRandomList(String local, BuildContext context) async {
    try {
      await getInitStoreList(local);
      getHomeRandomStoreList();
      getHomeRandomCafeList();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('인터넷 연결을 확인해주세요')));
      }
      storeLoadState = false;
      throw Exception(error);
    }
  }

  Future<void> getStoreAndRandomListSplash(
      String local, BuildContext context) async {
    try {
      await getInitStoreList(local);
      getHomeRandomStoreList();
      getHomeRandomCafeList();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('인터넷 연결을 확인해주세요')));
      }
      storeLoadState = false;
      Get.off(() => const MainPageTabbar());
      throw Exception(error);
    }
  }

  Future<void> getCategoryFilterList(String category) async {
    try {
      categoryFilterList.clear();
      for (StoreVo store in storeList) {
        if (store.CTGRY_THREE_NM == category) {
          categoryFilterList.add(store);
        }
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<StoreVo> getStoreDetail(String docId) async {
    try {
      StoreVo storeDetail = await dangoFirebaseService.getStoreDetail(docId);
      return storeDetail;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setStoreLoadState(bool state) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        storeLoadState = state;
        update();
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setLocationName(String location) async {
    try {
      localName = location;
      update();
    } catch (error) {
      throw Exception(error);
    }
  }
}
