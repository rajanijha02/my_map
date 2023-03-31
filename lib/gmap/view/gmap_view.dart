import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/gmap/controller/gmap_controller.dart';

class GMapView extends GetView<GMapController> {
  const GMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: controller.cameraPosition,
          mapType: MapType.normal,
          onMapCreated: (mapController) {
            controller.onMapCreated(mapController);
          },
          markers: Set<Marker>.of(controller.marker.values),
        );
      }),
    );
  }
}
