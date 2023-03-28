import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/model/history_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_map/storage_controller.dart';

class MapHistoryController extends GetxController {
  LocationHistory locationHistory = LocationHistory();
  RxList<LatLng> points = <LatLng>[].obs;
  late StorageController storageController;
  RxBool isLoading = false.obs;
  RxSet<Polyline> polyline = {
    const Polyline(
      polylineId: PolylineId('test'),
      points: [LatLng(00.00, 00.00)],
    )
  }.obs;
  @override
  void onInit() {
    super.onInit();
    locationHistory = Get.arguments;
    storageController = Get.find<StorageController>();
    points.value = [];
    loadLocation();
  }

  loadLocation() async {
    try {
      isLoading.value = true;
      http.Response response = await http.get(
        Uri.parse(
          'https://my-map.booringcodes.in/api/user/location?date=${locationHistory.date}',
        ),
        headers: {
          'Authorization': storageController.getToken(),
        },
      );

      if (response.statusCode == 200) {

        var data = json.decode(response.body)['locations'];
        print(data);
        for (var x in data) {
          points.add(LatLng(x['latitude'], x['longitude']));
        }
        polyline.clear();
        polyline.add(Polyline(
          polylineId: PolylineId(locationHistory.date ?? 'NOT_FOUND'),
          points: points.value,
        ));
        polyline.refresh();
        isLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: json.decode(response.body)['message']);
        isLoading.value = false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }
}
