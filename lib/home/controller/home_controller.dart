import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_map/storage_controller.dart';

class HomeController extends GetConnect implements GetxService {
  RxList<LatLng> points = <LatLng>[].obs;
  RxBool start = false.obs;
  RxInt sendCount = 0.obs;
  late StorageController storage;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storage = Get.find<StorageController>();
  }

  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(0.0, 0.0));
  Rx<MapType> mapType = MapType.normal.obs;
  RxMap<MarkerId, Marker> marker = {
    MarkerId('test'): Marker(
      markerId: MarkerId('test'),
      position: LatLng(0.0, 0.0),
    )
  }.obs;

  RxSet<Polyline> polyline = {
    const Polyline(
      polylineId: PolylineId('test'),
      color: Colors.blue,
      points: [
        LatLng(0.0, 0.0),
      ],
    ),
  }.obs;

  RxList<LatLng> point = <LatLng>[].obs;

  setMapType(value) {
    mapType.value = value;
  }

  mapController({required GoogleMapController mapController}) async {
    LocationPermission location = await Geolocator.checkPermission();

    if (location == LocationPermission.denied) {
      await Geolocator.requestPermission();
      location = await Geolocator.checkPermission();
      if (location == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Permission Denied by User');
      }
    }

    if (location == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission Denied Forever by User');
    }

    marker.clear();
    Position position = await Geolocator.getCurrentPosition();
    marker.value = {
      const MarkerId('current-location'): Marker(
        markerId: const MarkerId('current-location'),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    };
    marker.refresh();

    // This code will return current location on  200 ms
    Geolocator.getPositionStream().listen((event) async {
     
      point.add(LatLng(event.latitude, event.longitude));

      // Assigned New CameraPosition Value in cameraPosition Variable
      cameraPosition = CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 16);

      // Created new CameraUpdate Type variable
      CameraUpdate cameraUpdate =
          CameraUpdate.newCameraPosition(cameraPosition);

      // Moving camera to a location
      mapController.animateCamera(cameraUpdate);

      // Clear Polyline
      polyline.clear();
      polyline.add(
        Polyline(polylineId: PolylineId('My-polyline'), points: point.value),
      );
      polyline.refresh();
      
      if (start.isTrue) {
        await sendLocation(lat: event.latitude, lng: event.longitude);
      }
    });
  }

  sendLocation({required double lat, required double lng}) async {
    try {
      final url = Uri.parse('https://my-map.booringcodes.in/api/user/location');
      http.Response response = await http.post(
        url,
        headers: {"Authorization": storage.getToken()},
        body: {
          "lat": lat.toString(),
          "lng": lng.toString(),
        },
      );
      if (response.statusCode == 200) {
        sendCount.value += 1;
      } else {
        Fluttertoast.showToast(msg: json.decode(response.body)['message']);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
