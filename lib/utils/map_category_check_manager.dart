import 'package:flutter_naver_map/flutter_naver_map.dart';

import '../global/share_preference.dart';

class MapCategoryCheckManager {
  static final MapCategoryCheckManager instance =
  MapCategoryCheckManager._internal();

  factory MapCategoryCheckManager() => instance;

  MapCategoryCheckManager._internal();

  bool artGallery = prefs.getBool("check_artGallery") ?? false;
  bool cafe = prefs.getBool("check_cafe") ?? false;
  bool cottage = prefs.getBool("check_cottage") ?? false;
  bool korea_gate = prefs.getBool("check_korea_gate") ?? false;
  bool management = prefs.getBool("check_management") ?? false;
  bool museum = prefs.getBool("check_museum") ?? true;
  bool restaurant = prefs.getBool("check_restaurant") ?? false;
  bool salon = prefs.getBool("check_salon") ?? false;
  bool tools = prefs.getBool("check_tools") ?? false;
  bool trip = prefs.getBool("check_trip") ?? false;

  void setCheckValue(String category, bool check) {
    switch (category) {
      case '미술관':
        prefs.setBool("check_artGallery", check);
        artGallery = check;
      case '카페':
        prefs.setBool("check_cafe", check);
        cafe = check;
      case '펜션':
        prefs.setBool("check_cottage", check);
        cottage = check;
      case '문예회관':
        prefs.setBool("check_korea_gate", check);
        korea_gate = check;
      case '위탁관리':
        prefs.setBool("check_management", check);
        management = check;
      case '박물관':
        prefs.setBool("check_museum", check);
        museum = check;
      case '식당':
        prefs.setBool("check_restaurant", check);
        restaurant = check;
      case '미용':
        prefs.setBool("check_salon", check);
        salon = check;
      case '반려동물용품':
        prefs.setBool("check_tools", check);
        tools = check;
      case '여행지':
        prefs.setBool("check_trip", check);
        trip = check;
    }
  }

  bool? getCheckValue(String category) {
    switch (category) {
      case '미술관':
        return artGallery;
      case '카페':
        return cafe;
      case '펜션':
        return cottage;
      case '문예회관':
        return korea_gate;
      case '위탁관리':
        return management;
      case '박물관':
        return museum;
      case '식당':
        return restaurant;
      case '미용':
        return salon;
      case '반려동물용품':
        return tools;
      case '여행지':
        return trip;
    }
    return null;
  }

  NOverlayImage? getIconImage(String category) {
    switch (category) {
      case '미술관':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_art_gallery(100).png");
      case '카페':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_cafe(100).png");
      case '펜션':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_rental_cottage(100).png");
      case '문예회관':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_korea_gate(100).png");
      case '위탁관리':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_management(100).png");
      case '박물관':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_museum(100).png");
      case '식당':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_restaurant(100).png");
      case '미용':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_salon(100).png");
      case '반려동물용품':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_tools(100).png");
      case '여행지':
        return const NOverlayImage.fromAssetImage("assets/icons/map/icon_map_trip(100).png");
    }
    return null;
  }




}
