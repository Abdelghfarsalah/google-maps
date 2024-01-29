import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/modelmarker.dart';


class googlemap extends StatefulWidget {
  googlemap({super.key});
  State<googlemap> createState() => _googleState();
}

bool night = false;

class _googleState extends State<googlemap> {
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    makeMarkers();
    cameraPosition = const CameraPosition(
        zoom: 12, target: LatLng(30.412296204333504, 30.85361494491205));
  }

  void dispose() {
    super.dispose();
    googleMapController.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              changetosliver();
            },
            initialCameraPosition: cameraPosition),
        Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: ElevatedButton(
              child: const Text("Change camera"),
              onPressed: () {
                LatLng latLng =
                    const LatLng(31.171065037176977, 29.881153540839122);
                googleMapController
                    .animateCamera(CameraUpdate.newLatLng(latLng));
              },
            )),
        Positioned(
            top: 70,
            left: 10,
            right: 10,
            child: ElevatedButton(
              child: const Text("Change camera"),
              onPressed: () {
                if (night == true) {
                  changetosliver();
                  night = false;
                } else {
                  changetolight();
                  night = true;
                }
              },
            ))
      ],
    );
  }

  void changetolight() async {
    var file = await DefaultAssetBundle.of(context)
        .loadString("assets/google_style/dark.json");
    googleMapController.setMapStyle(file);
  }

  void changetosliver() async {
    var file = await DefaultAssetBundle.of(context)
        .loadString("assets/google_style/Silver.json");
    googleMapController.setMapStyle(file);
  }

  Future<Uint8List> getinfo({required String image, required int width}) async {
    var imagerow = await rootBundle.load(image);
    var imagecodec = await ui.instantiateImageCodec(
        imagerow.buffer.asUint8List(),
        targetWidth: width);
    var format = await imagecodec.getNextFrame();
    var result = await format.image.toByteData(format: ui.ImageByteFormat.png);
    return result!.buffer.asUint8List();
  }

  void makeMarkers() async {
    var markersPlaces = listplaces
        .map(
          (e) => Marker(
            position: e.latLng,
            infoWindow: InfoWindow(title: e.name),
            markerId: MarkerId(e.id.toString()),
          ),
        )
        .toSet();

    markers.addAll(markersPlaces);
    setState(() {});
  }
}
