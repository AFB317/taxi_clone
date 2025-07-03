import 'dart:io';

import 'package:duma_taxi/utils/constants.dart';
import 'package:duma_taxi/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import 'data_manager.dart';
import 'enumerations.dart';

bool checkConnectionError(e) {
  if (e.toString().contains('SocketException') ||
      e.toString().contains('HandshakeException')) {
    return true;
  } else {
    return false;
  }
}

String countryFlag(String countryCode) {
  int flagOffset = 0x1F1E6;
  int asciiOffset = 0x41;
  int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
  int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

  return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
}

Future authenticate(BuildContext context) async {
  PreferenceUtils.setPreference(isConnected, true);
  context.go("/${RouterPath.main}");
}

getHeaders() {
  var headers = {
    HttpHeaders.authorizationHeader:
        'Bearer 1537|CcFL2fGJcoRoI0QxgKZqFIbOLY0PhtcMcAfkrkEV708aa296',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptLanguageHeader: "en",
  };
  return headers;
}

Future<void> multipleRequests(List<Future<void> Function()> requests) async {
  for (final request in requests) {
    await request();
  }
}

Future<Place?> getAddressFromCoordinate(LatLng position) async {
  try {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark p = placeMarks[0];
    return Place.fromMap({
      "name": "${p.name}",
      "address":
          "${p.street},${p.subAdministrativeArea},${p.administrativeArea}",
      "lat": position.latitude,
      "lng": position.longitude,
    });
  } catch (e) {
    debugPrint("ERROR_FETCH_ADDRESS=$e");
    return null;
  }
}

String textFieldPlace(Place? place) {
  if (place != null) {
    return "${place.name}".length >= 10 ? "${place.name}" : "${place.address}";
  }
  return "";
}

void assignDate(DateTime dateTime) {
  DataManager().dateTime = customDateTime(dateTime);
  DateTime date = dateTime.add(const Duration(minutes: 2));
  DataManager().time = _getTime(date);
  DataManager().date = getDate(date);
}

String customDateTime(DateTime dT) {
  DateTime dateTime = dT.add(const Duration(minutes: 3));
  String d = "${getDate(dateTime)} ${_getTime(dateTime)}";
  return d;
}

String _getTime(DateTime selectedDate) {
  DateTime x = selectedDate.toLocal();
  String hour = "${x.hour}".length == 1 ? "0${x.hour}" : "${x.hour}";

  String min = "${x.minute}".length == 1 ? "0${x.minute}" : "${x.minute}";

  return "$hour:$min";
}

String getDate(DateTime selectedDate) {
  DateTime x = selectedDate.toLocal();

  String month = "${x.month}".length == 1 ? "0${x.month}" : "${x.month}";

  String day = "${x.day}".length == 1 ? "0${x.day}" : "${x.day}";

  return "${x.year}-$month-$day";
}

List<LatLng> decodePolyline(String encoded) {
  List<LatLng> points = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int destinationLatitude = (result & 1) != 0
        ? ~(result >> 1)
        : (result >> 1);
    lat += destinationLatitude;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int destinationLongitude = (result & 1) != 0
        ? ~(result >> 1)
        : (result >> 1);
    lng += destinationLongitude;

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }

  return points;
}

Future<BitmapDescriptor> adjustIconSize({
  required double zoomLevel,
  required String imageAssetPath,
}) async {
  double scaleFactor = 1.0;

  if (zoomLevel < 10) {
    scaleFactor = 0.5;
  } else if (zoomLevel < 15) {
    scaleFactor = 0.7;
  }

  return await BitmapDescriptor.asset(
    ImageConfiguration(size: Size(48 * scaleFactor, 48 * scaleFactor)),
    imageAssetPath,
  );
}

