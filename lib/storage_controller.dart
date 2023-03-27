import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'model/user_model.dart';

class StorageController extends GetxController{
  GetStorage getstorage=GetStorage();
  Rx<UserModel> user= UserModel().obs;

  setUserData(UserModel data){
    user.value=data;
  }

getUserData(){
  return user.value;
}

getToken(){
  return getstorage.read('token');
}

setToken(String token){
  getstorage.write('token', token);
}

removeToken(){
  getstorage.remove('token');
}

}