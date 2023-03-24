import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetConnect implements GetxService {
  Rx<Polyline> polylines = Polyline(
    polylineId: PolylineId('test'),
    points: [],
  ).obs;
  RxList<LatLng> points = <LatLng>[].obs;
  loadLocation(GoogleMapController controller) async {
    LocationPermission location = await Geolocator.checkPermission();

    if (location == LocationPermission.denied) {
      await Geolocator.requestPermission();
      location = await Geolocator.checkPermission();
      if (location == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Permission Denied by User');
      }
    }

    if (location == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission Denied Forever');
    }

    Geolocator.getPositionStream().listen(
      (event) {
        print(event.latitude);
        print(event.longitude);
        CameraPosition cameraPosition = CameraPosition(
            target: LatLng(event.latitude, event.longitude), zoom: 26);
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        points.add(
          LatLng(event.latitude, event.longitude),
        );
        polylines.value =
            Polyline(polylineId: PolylineId('test'), points: points.value,color: Colors.black,);
      },
    );
  }
}
