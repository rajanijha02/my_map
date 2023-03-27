import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_map/model/user_model.dart';
import 'package:my_map/storage_controller.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool showhidepassword = true.obs;
  RxBool isloading = false.obs;
  late StorageController storage;

  

  showHidePassword() {
    if (showhidepassword.value == false) {
      showhidepassword.value = true;
    } else {
      showhidepassword.value = false;
    }
  }

  performlogin() async {
    if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter email');
    } else if (password.text.isEmpty) {
      Fluttertoast.showToast(msg: "please enter password");
    } else {
      try {
        isloading.value = true;
        final url = Uri.parse('https://my-map.booringcodes.in/api/user/login');
        http.Response response = await http
            .post(url, body: {"email": email.text, "password": password.text});

            if(response.statusCode==200){
              Fluttertoast.showToast(msg: 'Logged in');
              var res=json.decode(response.body);
              await storage.setToken(res['token']);
              UserModel userModel=UserModel.fromJson(res['user']);
              storage.setUserData(userModel);
              Get.offAndToNamed('/home');
            }else{
              Fluttertoast.showToast(msg: json.decode(response.body)['messase']);
            }
            isloading.value=false;
      } catch (e) {
          isloading.value=false;
          Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storage=Get.find<StorageController>();
  }

}
