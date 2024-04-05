


import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:project_dangoing/utils/permission_manager.dart';

class LocationController extends GetxController {

  LocationData? locationData;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    locationData = await location.getLocation();
  }

  // 퍼미션 체크가 되어있는
  // void getLocation() async {
  //   Location location = Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if(!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if(!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //
  //   if(_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if(_permissionGranted != PermissionStatus.granted) {
  //       return ;
  //     }
  //   }
  //
  //   locationData = await location.getLocation();
  //   update();
  // }
}