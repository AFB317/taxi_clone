import 'package:duma_taxi/utils/functions.dart';
import 'package:flutter/material.dart';
import '../api.dart';
import '../data_manager.dart';
import '../enumerations.dart';

class ConnectedProvider extends ChangeNotifier {
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loaded;

  Future getData() async {
    multipleRequests([getDrivers]);
  }

  Future getDrivers() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      await Api.getDriversP().then((values) {
        if (values.isNotEmpty) {
          DataManager().positionStream.setDriverPositions(values);
        }
      });
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  void checkError(e) {
    if (checkConnectionError(e)) {
      setApiRequestStatus(ApiRequestStatus.connectionError);
    } else {
      setApiRequestStatus(ApiRequestStatus.error);
    }
  }

  void setApiRequestStatus(ApiRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
