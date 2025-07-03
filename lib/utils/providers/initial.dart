import 'package:duma_taxi/models/payment.dart';
import 'package:flutter/material.dart';

import '../../models/country.dart';
import '../api.dart';
import '../data_manager.dart';
import '../enumerations.dart';
import '../functions.dart';
import '../languages/constants.dart';

class InitialProvider extends ChangeNotifier {
  List<Country> _countries = Country.defaultCountries;
  List<PaymentMethod> _paymentMethods = PaymentMethod.defaultPaymentMethods;
  PaymentMethod _selectedPayment = PaymentMethod.defaultPaymentMethods.first;

  List<Country> get countries => List.from(_countries);

  List<PaymentMethod> get paymentMethods => List.from(_paymentMethods);

  PaymentMethod? get selectedPayment => _selectedPayment;

  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loaded;

  getData() async {
    String lang = await getLocale().then((locale) => locale.languageCode);
    DataManager().language = lang;
    multipleRequests([_getCountries, _getPaymentMethods]);
  }

  Future _getCountries() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      await Api.getCountries().then((values) {
        if (values.isNotEmpty) {
          _countries = values;
        }
      });
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  Future _getPaymentMethods() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      await Api.getPaymentMethods().then((values) {
        if (values.isNotEmpty) {
          _paymentMethods = values;
          _selectedPayment =
              values.firstWhere((element) => "${element.id}" == "2");
          DataManager().paymentMethods = values;
        }
      });
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  selectedPaymentMethod(PaymentMethod paymentMethod) {
    _selectedPayment = paymentMethod;
    notifyListeners();
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
