import 'package:get/get.dart';
import 'package:my_map/gmap/controller/gmap_controller.dart';
import 'package:my_map/history/controller/history_controller.dart';
import 'package:my_map/home/controller/home_controller.dart';
import 'package:my_map/login/controller/login_controller.dart';
import 'package:my_map/maphistory/controller/maphistory_controller.dart';
import 'package:my_map/register/controller/register_controller.dart';
import 'package:my_map/splash/controller/splash_controller.dart';
import 'package:my_map/storage_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LoginController());
  }
}

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RegisterController());
  }
}

class StorageBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(StorageController());
  }
}

class HistoryBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HistoryController());
  }
}

class MapHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MapHistoryController());
  }
}

class GMapBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GMapController());
  }
}
