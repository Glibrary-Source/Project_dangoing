import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:project_dangoing/controller/location_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationController locationController = Get.find();

  @override
  void initState() {
    locationController.getLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: locationController.locationData != null
            ? NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: NLatLng(
                  locationController.locationData?.latitude ?? 126.9816417,
                  locationController.locationData?.longitude ?? 37.57037778),
              zoom: 15,
            ),
          ),
          onMapReady: (controller) {
            print("네이버 맵 로딩됨!");
          },
        )
            : SizedBox()
      );
    });
  }
}
