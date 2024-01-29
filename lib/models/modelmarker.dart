import 'package:google_maps_flutter/google_maps_flutter.dart';

class placeholder {
  final int id;
  final LatLng latLng;
  final String name;

  placeholder({required this.id, required this.latLng, required this.name});
  
}

List<placeholder> listplaces=[
  placeholder(id: 1,
  latLng:const LatLng(30.412296204333504, 30.85361494491205) , name: "place one"),
  placeholder(id: 2,
  latLng:const LatLng(30.413628569959226, 30.86245550522686) , name: "place tow"),
  placeholder(id: 2,
  latLng:const LatLng(30.409631418522128, 30.856018204026768) , name: "place three"),
];  