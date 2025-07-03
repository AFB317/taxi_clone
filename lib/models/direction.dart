import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction {
  LatLng origin;
  LatLng destination;
  Polyline polyline;
  GetValue duration;
  GetValue distance;

  Direction({
    required this.origin,
    required this.destination,
    required this.polyline,
    required this.duration,
    required this.distance,
  });
}
class GetValue {
  dynamic text, value;

  GetValue.fromJson(Map d) {
    text = d["text"];
    value = d["value"];
  }
}