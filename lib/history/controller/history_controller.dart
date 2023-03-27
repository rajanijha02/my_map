import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_map/model/history_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_map/storage_controller.dart';

class HistoryController extends GetxController {
  late StorageController storage;
  RxBool isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
    storage = Get.find<StorageController>();
    loadHistory();
  }

  RxList<LocationHistory> history = <LocationHistory>[].obs;

  loadHistory() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('https://my-map.booringcodes.in/api/user/history');
      http.Response response = await http.get(url, headers: {
        'Authorization': storage.getToken(),
      });
      history.clear();
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Data loaded');
        for (var data in body['locations']) {
          LocationHistory locationHistory = LocationHistory.fromJson(data);
          history.add(locationHistory);
        }
        history.refresh();
        isLoading.value = false;
      } else {
        Fluttertoast.showToast(msg: body['message']);
        isLoading.value = false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading.value = false;
    }
  }
}
