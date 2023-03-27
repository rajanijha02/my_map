import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/history');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 7, 21, 73),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'History',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Obx(() {
                  return controller.start.isTrue
                      ? Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.start.value = false;
                              Fluttertoast.showToast(
                                  msg: 'Closed location listner');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Uploaded Location'),
                                  Text(controller.sendCount.value.toString())
                                ],
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.start.value = true;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 7, 21, 73),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Start',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return GoogleMap(
                initialCameraPosition: controller.cameraPosition,
                compassEnabled: true,
                mapToolbarEnabled: true,
                mapType: controller.mapType.value,

                // This will return GoogleMapController to controle this map
                onMapCreated: (mapController) {
                  controller.mapController(mapController: mapController);
                },

                markers: Set<Marker>.of(controller.marker.values),
                polylines: controller.polyline.value,
              );
            }),
          ),
          SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButtonFormField(
                value: controller.mapType.value,
                items: const [
                  DropdownMenuItem(
                    child: Text('MapType.hybrid'),
                    value: MapType.hybrid,
                  ),
                  DropdownMenuItem(
                    child: Text('MapType.none'),
                    value: MapType.none,
                  ),
                  DropdownMenuItem(
                    child: Text('MapType.normal'),
                    value: MapType.normal,
                  ),
                  DropdownMenuItem(
                    child: Text('MapType.satellite'),
                    value: MapType.satellite,
                  ),
                  DropdownMenuItem(
                    child: Text('MapType.terrain'),
                    value: MapType.terrain,
                  ),
                ],
                onChanged: (value) {
                  controller.setMapType(value);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}

/**
 * 
 * -> For create polylines
 * 
 */
