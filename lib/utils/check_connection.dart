import 'dart:async';

import 'package:duma_taxi/screens/pages/main/main.dart';
import 'package:duma_taxi/screens/pages/welcome.dart';
import 'package:duma_taxi/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../screens/widgets/no_internet.dart';
import 'constants.dart';

class CheckConnection extends StatefulWidget {
  const CheckConnection({super.key});

  @override
  State<CheckConnection> createState() => _CheckConnectionState();
}

class _CheckConnectionState extends State<CheckConnection> {
  bool connected = PreferenceUtils.getPreference(isConnected, false);
  bool hasInternet = true;
  late StreamSubscription internetSubscription;

  @override
  void initState() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
          final hasInternet = status == InternetConnectionStatus.connected;
          setState(() {
            this.hasInternet = hasInternet;
          });
        });
    super.initState();
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _nextScreen();
  }

  _nextScreen() {
    return !hasInternet
        ? const NoInternetWidget()
        : connected == false
        ? const WelcomePage()
        : const MainPage();
  }
}
