import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_map/model/user_model.dart';
import 'package:my_map/storage_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SplashController extends GetxController {
  late StorageController storage;
  @override
  void onInit() {
    super.onInit();
    storage = Get.find<StorageController>();
    Timer(Duration(seconds: 2), () {validateToken(); });
    
  }

  validateToken() async {
    String? token = storage.getToken();
    if (token == null) {
      Get.offAndToNamed('/login');
    } else {
      try {
        final url = Uri.parse('https://my-map.booringcodes.in/api/user/me');
        http.Response response =
            await http.get(url, headers: {'Authorization': token});
        if (response.statusCode == 200) {
          UserModel userModel =
              UserModel.fromJson(json.decode(response.body)['user']);
          storage.setUserData(userModel);
          Fluttertoast.showToast(msg: 'Logged in');
          Get.offAndToNamed('/home');
        } else {
          Fluttertoast.showToast(msg: json.decode(response.body)['message']);
          Get.offAndToNamed('/login');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        Get.offAndToNamed('/login');
      }
    }
  }
}
/**
 * 
 * -> Firebase 
 * 
 * 
 */