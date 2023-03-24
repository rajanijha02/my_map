import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
            ),
            onMapCreated: controller.loadLocation,
            polylines: Set.of([controller.polylines.value]),
          );
        },
      ),
    );
  }
}
