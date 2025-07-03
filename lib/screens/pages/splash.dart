import 'package:duma_taxi/screens/widgets/dialogs.dart';
import 'package:duma_taxi/utils/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import '../../utils/constants.dart';
import '../../utils/enumerations.dart';
import '../../utils/languages/constants.dart';
import '../../utils/languages/models.dart';
import '../../utils/preferences.dart';
import '../widgets/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  bool _isLoadingPage = true,
      _isRequesting = false,
      _isPermanentlyDenied = false,
      isLangSet = PreferenceUtils.getPreference(langSet, false);
  String? _error;

  @override
  void initState() {
    super.initState();
    startAnimation();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isLangSet == false) {
        languageDialog(context, Language.languageList);
      }
    });
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _isLoadingPage
            ? SplashWidget()
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(noLocationFound, width: 100, height: 100),
                      const SizedBox(height: 20),
                      Text(
                        "${getTranslated(context, 'allow_location_title')}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "${getTranslated(context, 'allow_location_message')}",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      if (_error != null)
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _isRequesting ? null : _requestPermission,
                        icon: const Icon(Icons.location_on),
                        label: Text(
                          "${getTranslated(context, 'allow_location')}",
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_error != null && !_isPermanentlyDenied)
                        TextButton.icon(
                          onPressed: _isRequesting ? null : _requestPermission,
                          icon: const Icon(Icons.refresh),
                          label: Text("${getTranslated(context, "try_again")}"),
                        ),
                      if (_isPermanentlyDenied)
                        TextButton.icon(
                          onPressed: _openAppSettings,
                          icon: const Icon(Icons.settings),
                          label: Text(
                            "${getTranslated(context, 'open_settings')}",
                          ),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future startAnimation() async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (!mounted) return;
      setState(() {
        _isLoadingPage = false;
      });
    });
  }

  Future<void> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _error = "Location services are disabled.");
      return;
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );
      _goToNextPage(position);
    } else if (permission == LocationPermission.deniedForever) {
      setState(() {
        _error = "Permission permanently denied. Please enable it in settings.";
        _isPermanentlyDenied = true;
      });
    }
  }

  Future<void> _requestPermission() async {
    setState(() {
      _isRequesting = true;
      _error = null;
      _isPermanentlyDenied = false;
    });

    final permission = await Geolocator.requestPermission();
    setState(() => _isRequesting = false);

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );
      _goToNextPage(position);
    } else if (permission == LocationPermission.deniedForever) {
      setState(() {
        _error = "${getTranslated(context, 'open_settings')}";
        _isPermanentlyDenied = true;
      });
    } else {
      setState(() {
        _error = "${getTranslated(context, 'allow_location_title')}";
      });
    }
  }

  void _goToNextPage(Position position) {
    DataManager().positionStream.startTracking(position);
    context.go("/${RouterPath.check}");
  }

  Future<void> _openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
