import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RegisterController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool showhidepassword = true.obs;
  RxBool isloading = false.obs;

  showHidePassword() {
    if (showhidepassword.value == false) {
      showhidepassword.value = true;
    } else {
      showhidepassword.value = false;
    }
  }

  performRegistration() async {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter name');
    } else if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter email');
    } else if (password.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter password');
    } else {
      try {
        isloading.value = true;
        final url =
            Uri.parse('https://my-map.booringcodes.in/api/user/register');
        http.Response response = await http.post(url, body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });

        if(response.statusCode==200){
          Fluttertoast.showToast(msg: 'Account created');
          name.text='';
          email.text='';
          password.text='';
        }else{
          Fluttertoast.showToast(msg: json.decode(response.body)['message']);
        }
        isloading.value=false;
      } catch (e) {
        isloading.value=false;
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
