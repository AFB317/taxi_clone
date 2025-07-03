import 'package:duma_taxi/models/service_type.dart';
import 'package:duma_taxi/utils/streams/location.dart';
import 'package:duma_taxi/utils/streams/places.dart';
import 'package:duma_taxi/utils/streams/screen.dart';

import '../models/payment.dart';

class DataManager {
  static final DataManager _instance = DataManager._internal();

  DataManager._internal();

  factory DataManager() {
    return _instance;
  }

  String language = "en";
  List<PaymentMethod> paymentMethods = [];
  PlaceStream placeStream = PlaceStream();
  PositionStream positionStream = PositionStream();
  ScreenStateStream screenStream = ScreenStateStream();
  ServiceType selectedService = ServiceType();
  String time = '';
  String date = '';
  String dateTime = '';
}
