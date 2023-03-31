import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapController extends GetConnect implements GetxService {
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(0.0, 0.0),
  );

  RxMap<MarkerId, Marker> marker = {
    const MarkerId('test'): const Marker(
      markerId: MarkerId('test'),
      position: LatLng(0.0, 0.0),
    )
  }.obs;

  onMapCreated(GoogleMapController mapController) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'permission denied by user');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission denied forever');
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    CameraPosition newPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));

    Geolocator.getPositionStream().listen((event) {
      CameraPosition position = CameraPosition(
          target: LatLng(event.latitude, event.longitude), zoom: 16);
      mapController.animateCamera(CameraUpdate.newCameraPosition(position));

      marker.clear();

      Map<MarkerId, Marker> tempMarker = {
        const MarkerId('current-location'): Marker(
          markerId: const MarkerId('current-location'),
          position: LatLng(event.latitude, event.longitude),
        )
      };

      marker.value = tempMarker;
      marker.refresh();
    });
  }
}
