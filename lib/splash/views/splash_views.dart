import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_map/splash/controller/splash_controller.dart';

class SplashViews extends GetView<SplashController> {
  const SplashViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
