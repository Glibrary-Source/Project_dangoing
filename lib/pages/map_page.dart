import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_dangoing/component/map_category_widget.dart';
import 'package:project_dangoing/controller/location_controller.dart';
import 'package:project_dangoing/controller/store_controller.dart';
import 'package:project_dangoing/data/category_list_data.dart';
import 'package:project_dangoing/theme/colors.dart';
import 'package:project_dangoing/utils/map_status_manager.dart';
import 'package:project_dangoing/utils/permission_manager.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ExpansionTileController categoryTileController = ExpansionTileController();

  LocationController locationController = Get.find();
  StoreController storeController = Get.find();
  PermissionManager permissionManager = PermissionManager();
  MapStatusManager mapStatusManager = MapStatusManager();
  CategoryListData categoryListData = CategoryListData();
  bool categoryExtend = false;

  var lastPopTime;
  NaverMapController? naverMapController;

  @override
  void initState() {
    permissionManager.locationPermission();
    super.initState();
  }

  @override
  void dispose() {
    naverMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        final now = DateTime.now();
        if (lastPopTime == null ||
            now.difference(lastPopTime) > const Duration(seconds: 2)) {
          lastPopTime = now;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('뒤로 버튼을 한번 더 누르면 앱이 종료됩니다.'),
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
                initialCameraPosition: mapStatusManager.nCameraPosition ??
                    const NCameraPosition(
                      target: NLatLng(37.57037778, 126.9816417),
                      zoom: 13,
                    ),
                extent: const NLatLngBounds(
                  southWest: NLatLng(31.43, 122.37),
                  northEast: NLatLng(44.35, 132.0),
                ),
                logoAlign: NLogoAlign.rightBottom,
                logoMargin: const EdgeInsets.all(10),
                liteModeEnable: true),
            onMapReady: (controller) async {
              naverMapController = controller;

              if (mapStatusManager.mapLoadFirst) {
                myLocationAddMarker(permissionManager);
                mapStatusManager.checkMapFirstLoad();
              }

              await MapStatusManager()
                  .setMarkerList(naverMapController!, storeController, context);
              MapStatusManager().visibleManager();
            },
            onCameraIdle: () async {
              var position = naverMapController?.nowCameraPosition;
              mapStatusManager.currentCameraPosition(position);
              categoryTileController.collapse();
            },
            onMapTapped: (NPoint point, NLatLng latLng) {
              categoryTileController.collapse();
              naverMapController!.clearOverlays(type: NOverlayType.infoWindow);
            },
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                        onPressed: () async {
                          myLocationAddMarker(permissionManager);
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: dangoingColorOrange500,
                        ))),
                GetBuilder<LocationController>(builder: (locationController) {
                  return locationController.locationState
                      ? Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                              color:
                                  CupertinoColors.systemGrey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100)),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: dangoingColorOrange500,
                          ))
                      : const SizedBox();
                }),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.04,
            left: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: CupertinoColors.systemGrey2, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: ExpansionTile(
                controller: categoryTileController,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                collapsedShape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: const Text(" 카테고리별로 보기"),
                backgroundColor: Colors.white,
                collapsedBackgroundColor: Colors.white,
                children: [
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 4.0),
                    padding: EdgeInsets.zero,
                    itemCount: categoryListData.categoryMap.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MapCategoryWidget(
                        categoryName:
                            categoryListData.categoryMap.keys.toList()[index],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void myLocationAddMarker(PermissionManager permissionManager) async {
    locationController.setLocationState(true);

    if (await permissionCheck()) {
      try {
        await locationController.getCurrentLocation();
      } catch (e) {
        locationController.setLocationState(false);
      }

      final myLatLng = NLatLng(
          locationController.locationData?.latitude ?? 37.57037778,
          locationController.locationData?.longitude ?? 126.9816417);

      final position = NCameraUpdate.withParams(target: myLatLng, zoom: 13);

      const iconImage = NOverlayImage.fromAssetImage(
          "assets/icons/map/icon_current_location(50).png");

      final myLocationMarker =
          NMarker(id: "myLocation", position: myLatLng, icon: iconImage);

      naverMapController?.updateCamera(position);
      naverMapController?.addOverlay(myLocationMarker);

      locationController.setLocationState(false);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치 권한을 확인해주세요'),
        ),
      );
      locationController.setLocationState(false);
    }
  }

  Future<bool> permissionCheck() async {
    if ("${await Permission.location.status}" ==
            "PermissionStatus.permanentlyDenied" ||
        "${await Permission.location.status}" == "PermissionStatus.denied") {
      return false;
    } else {
      return true;
    }
  }
}
