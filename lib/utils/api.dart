import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:duma_taxi/models/drivers_position.dart';
import 'package:duma_taxi/utils/data_manager.dart';
import 'package:duma_taxi/utils/theme/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/car_type.dart';
import '../models/country.dart';
import '../models/direction.dart';
import '../models/payment.dart';
import '../models/place.dart';
import 'constants.dart';
import 'functions.dart';

class Api {
  static Future<List<Country>> getCountries() async {
    List<Country> data = [];
    try {
      var res = await Dio().get(
        "$baseUrl/country",
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      data = (res.data['data'] as List)
          .map(
            (element) => Country.fromJson(element),
      )
          .toList();
      return data;
    } on DioException catch (e) {
      debugPrint("ERROR_COUNTRY=${e.response}");
    }
    return data;
  }

  static Future<List<PaymentMethod>> getPaymentMethods() async {
    List<PaymentMethod> data = [];
    try {
      var res = await Dio().get(
        "$baseUrl/payment-method",
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      data = (res.data['data'] as List)
          .map(
            (element) => PaymentMethod.fromJson(element),
      )
          .toList();
      return data;
    } on DioException catch (e) {
      debugPrint("ERROR_PAYMENTS=${e.response}");
    }
    return data;
  }

  static Future<List<DriversP>> getDriversP() async {
    try {
      var res = await Dio().get(
        "$baseUrl/driver",
        options: Options(
          headers: getHeaders(),
        ),
      );
      List<DriversP> data = (res.data['data'] as List)
          .where((element) => element['location'] != null)
          .map(
            (element) => DriversP.fromJson(element),
      )
          .toList();
      if (data.length > 10) {
        return data.sublist(0, 9);
      } else {
        return data;
      }
    } on DioException catch (e) {
      debugPrint("ERROR_DRIVERS_POSITIONS=${e.response}");
    }
    return [];
  }

  static Future<List<Place>> searchPlaces(BuildContext context,
      {required String text}) async {
    List<Place> data = [];
    String url = "$baseUrl/search/place/new";
    var params = {"textQuery": text, "country": "BI"};
    try {
      var res = await Dio().post(
        url,
        data: params,
        options: Options(
          headers: getHeaders(),
        ),
      );
      final items = res.data['data'];
      if (items is List) {
        final data = items.map((e) => Place.fromJson(e)).toList();
        return data;
      } else {
        debugPrint("Expected a List, got: ${items.runtimeType}");
      }
    } on DioException catch (e) {
      debugPrint("ERROR_PLACES=${e.response}");
    }
    return data;
  }

  static Future<Direction?> fetchRoute(
      LatLng origin, LatLng destination, int polyId) async {
    try {
      final url =
          'https://us1.locationiq.com/v1/directions/driving/${origin.longitude},${origin.latitude};'
          '${destination.longitude},${destination.latitude}?key=$iQKey&overview=full';
      var res = await Dio().get(
        url,
        options: Options(
          headers: getHeaders(),
        ),
      );
      dynamic data = res.data;

      final points = data['routes'][0]['geometry'];
      List<LatLng> routeCoords = decodePolyline(points);

      //Set polyline
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly$polyId"),
          geodesic: true,
          points: routeCoords,
          width: 4,
          color: ThemeSettings.lightPrimary);

      final route = data['routes'][0];
      final dist = route['distance'];
      final dur = route['duration'];

      var durMap = {
        "text": "mins",
        "value": "${(dur / 60).toStringAsFixed(0)}",
      };

      var distMap = {
        "text": "km",
        "value": "${(dist / 1000).toStringAsFixed(2)}",
      };
      GetValue distance = GetValue.fromJson(distMap);
      GetValue duration = GetValue.fromJson(durMap);

      return Direction(
        origin: origin,
        destination: destination,
        polyline: polyline,
        duration: duration,
        distance: distance,
      );
    } on DioException catch (e) {
      debugPrint("ERROR_DIRECTIONS=${e.response}");
    }
    return null;
  }

  static Future<List<CarType>> getEstimationPrice(
      {required String distance, required List<double> distances,required String time}) async {
    List<CarType> data = [];
    String url = "$baseUrl/price/${DataManager().selectedService.id}";
    var params = {
      "country": "BI",
      "distance": distance,
      "time": time,
      "distances": jsonEncode(distances),
    };
    try {
      var res = await Dio().post(
        url,
        data: params,
        options: Options(
          headers: getHeaders(),
        ),
      );
      data = (res.data['prices'] as List)
          .map(
            (element) => CarType.fromJson(
          json: element['race_type'],
          p: element['price'],
          c: element['currency'],
        ),
      )
          .toList();
      return data;
    } on DioException catch (e) {
      debugPrint("ERROR_PRICE=${e.response}");
    }
    return data;
  }

}
