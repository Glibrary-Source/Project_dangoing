import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:project_dangoing/controller/location_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/service/dango_firebase_service.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/permission_manager.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationController locationController = Get.find();
  StoreController storeController = Get.find();
  PermissionManager permissionManager = PermissionManager();


  var lastPopTime;
  NaverMapController? naverMapController;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        final now = DateTime.now();
        if (lastPopTime == null ||
            now.difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = now;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('뒤로 버튼을 한 번 더 누르면 앱이 종료됩니다.'),
            ),
          );
          return;
        } else {
          // 두 번 연속으로 뒤로가기 버튼을 누르면 앱 종료
          exit(0);
        }
      },
      child: Scaffold(
          body: Stack(
            children: [
              NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(
                        37.57037778,
                        126.9816417),
                    zoom: 13,
                  ),
                  extent: NLatLngBounds(
                    southWest: NLatLng(31.43, 122.37),
                    northEast: NLatLng(44.35, 132.0),
                  ),
                ),
                onMapReady: (controller) async {
                  naverMapController = controller;
                  addStoreMarker();
                },
              ),
              Positioned(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                        onPressed: () async {
                          myLocationAndMarker();
                        },
                        icon: Icon(
                          Icons.location_on,
                          color: dangoingMainColor,
                        ))),
                bottom: 10,
                left: 10,
              )
            ],
          )),
    );
  }



  void addStoreMarker() async {
    final marker = NMarker(id: 'test',position: NLatLng(37.506932467450326, 127.05578661133796));
    naverMapController?.addOverlay(marker);

    List<NAddableOverlay> overlay = [];

    final iconImage = NOverlayImage.fromAssetImage("assets/icons/icon_map_cafe.png");

    for (var doc in storeController.storeList) {
      if(doc.CTGRY_THREE_NM == "미용") {
        final myLatLng = NLatLng(doc.LC_LA!, doc.LC_LO!);
        final myLocationMarker = NMarker(
            id: "${doc.FCLTY_NM}", position: myLatLng, icon: iconImage);

        overlay.add(myLocationMarker);
      }
    }

    Set<NAddableOverlay> test = Set.from(overlay);

    naverMapController?.addOverlayAll(test);
  }

  void myLocationAndMarker() async {
    permissionManager.locationPermission();
    await locationController.getCurrentLocation();

    final myLatLng = NLatLng(
        locationController.locationData?.latitude ?? 0,
        locationController.locationData?.longitude ?? 0);

    final position = NCameraUpdate.withParams(
        target: myLatLng,
        zoom: 13);

    final iconImage = NOverlayImage.fromAssetImage("assets/icons/icon_current_location.png");

    final myLocationMarker = NMarker(
        id: "myLocation", position: myLatLng, icon: iconImage);

    naverMapController?.updateCamera(position);
    naverMapController?.addOverlay(myLocationMarker);
  }
}