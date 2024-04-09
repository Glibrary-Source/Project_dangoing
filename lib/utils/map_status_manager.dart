
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/category_list_data.dart';
import 'package:project_dangoing/pages/store_detail_page.dart';

import 'map_category_check_manager.dart';

class MapStatusManager {
  static final MapStatusManager instance = MapStatusManager._internal();

  factory MapStatusManager() => instance;

  MapStatusManager._internal();

  CategoryListData categoryListData = CategoryListData();
  MapCategoryCheckManager mapCategoryCheckManager = MapCategoryCheckManager();
  bool mapLoadFirst = true;
  NCameraPosition? nCameraPosition;
  Map<String, List<NAddableOverlay>> storeMarkerMap = {};

  void checkMapFirstLoad() {
    mapLoadFirst = false;
  }

  void currentCameraPosition(NCameraPosition? currentCameraPosition) async {
    nCameraPosition = currentCameraPosition;
  }

  Future<void> setMarkerList(NaverMapController naverMapController,
      StoreController storeController, BuildContext context) async {
    storeMarkerMap.clear();

    for (String category in categoryListData.categoryMap.keys) {
      List<NAddableOverlay> overlay = [];

      var iconImage = MapCategoryCheckManager().getIconImage(category);

      for (var doc in storeController.storeList) {
        if (doc.CTGRY_THREE_NM == category) {
          final myLatLng = NLatLng(doc.LC_LA!, doc.LC_LO!);

          final myLocationMarker = NMarker(
              id: "${doc.FCLTY_NM}", position: myLatLng, icon: iconImage);

          final infoWindow = NInfoWindow.onMarker(
              id: "${doc.FCLTY_NM}", text: "${doc.FCLTY_NM}");


          myLocationMarker.setOnTapListener((nMarker) {

            infoWindow.setOnTapListener((overlay) {
              Get.to(() => const StoreDetailPage(), arguments: doc.DOC_ID);
            });

            naverMapController.clearOverlays(type: NOverlayType.infoWindow);
            myLocationMarker.openInfoWindow(infoWindow);
          });

          overlay.add(myLocationMarker);
          myLocationMarker.setIsVisible(false);
        }
      }

      Set<NAddableOverlay> setOverlay = Set.from(overlay);

      storeMarkerMap[category] = overlay;

      naverMapController.addOverlayAll(setOverlay);
    }
  }

  void visibleManager() {
    for (String category in categoryListData.categoryMap.keys) {
      if (mapCategoryCheckManager.getCheckValue(category)!) {
        for (var marker in storeMarkerMap[category]!) {
          marker.setIsVisible(true);
        }
      }
    }
  }
}
