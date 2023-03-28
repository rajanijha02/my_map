import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/maphistory/controller/maphistory_controller.dart';

class MapHistoryView extends GetView<MapHistoryController> {
  const MapHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 21, 73),
        title: Text(
          controller.locationHistory.date!,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.points[0],
                  zoom: 16,
                ),
                polylines: controller.polyline,
                markers: Set<Marker>.of(
                  {
                    Marker(
                      markerId: MarkerId(
                        controller.locationHistory.date ?? 'TEST',
                      ),
                      position: controller.points[0],
                    ),
                    Marker(
                      markerId: MarkerId('END'),
                      position: controller.points[controller.points.length - 1],
                    )
                  },
                ),
              );
      }),
    );
  }
}
