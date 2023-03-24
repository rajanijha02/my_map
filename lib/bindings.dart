import 'package:get/get.dart';
import 'package:my_map/home/controller/home_controller.dart';
import 'package:my_map/splash/controller/splash_controller.dart';
class HomeBindings extends Bindings{
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