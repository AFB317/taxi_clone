import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/drivers_position.dart';
import '../../../utils/constants.dart';
import '../../../utils/data_manager.dart';
import '../../../utils/functions.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> with WidgetsBindingObserver {
  late LatLng myPosition;
  final Completer<GoogleMapController> _controller = Completer();
  Marker? _pinMarker;
  Set<Marker> driversMarkers = {};
  BitmapDescriptor? _liveIcon;
  double _zoomLevel = 15;
  final double _levelUp = 0.003;
  Set<Polyline> polylines = {};

  @override
  void initState() {
    myPosition = initialPosition;
    _loadPinMarker();
    DataManager().positionStream.dPositions.listen((events) {
      if (mounted) {
        for (var element in events) {
          _setDriversMarker(element);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          key: Key("GoogleKeyMap"),
          style: 'assets/map_style.json',
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          gestureRecognizers: <Factory<PanGestureRecognizer>>{}
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
          initialCameraPosition: CameraPosition(
            target: LatLng(
              myPosition.latitude - _levelUp,
              myPosition.longitude,
            ),
            zoom: _zoomLevel,
          ),
          onMapCreated: (controller) {
            _onMapCreated(controller);
          },
          markers: {if (_pinMarker != null) _pinMarker!, ...driversMarkers},
          polylines: polylines,
          onCameraMove: (position) {
            setState(() {
              _zoomLevel = position.zoom;
              _updateIconBasedOnZoom(_zoomLevel);
            });
          },
        ),
        Positioned(
          top: 50,
          right: 20,
          child: FloatingActionButton(
            heroTag: 'my_actual_location',
            mini: true,
            onPressed: _goToMyLocation,
            child: Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    DataManager().positionStream.position.listen((event) {
      setState(() {
        myPosition = LatLng(event.latitude, event.longitude);
        _pinMarker = Marker(
          markerId: const MarkerId("live_position"),
          position: LatLng(event.latitude, event.longitude),
          icon: _liveIcon ?? BitmapDescriptor.defaultMarker,
          rotation: event.heading,
          anchor: const Offset(0.5, 0.5),
          flat: true,
        );
        _moveCamera(event.latitude, event.longitude);
      });
    });
  }

  Future<void> _moveCamera(double lat, double lng) async {
    final ctrl = await _controller.future;
    final currentZoom = await ctrl.getZoomLevel();
    await ctrl.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat - _levelUp, lng), zoom: currentZoom),
      ),
    );
  }

  void _loadPinMarker() async {
    _liveIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(30, 30)),
      personImage,
    );
  }

  void _updateIconBasedOnZoom(double zoom) async {
    final icon = await adjustIconSize(
      zoomLevel: zoom,
      imageAssetPath: personImage,
    );
    setState(() {
      _liveIcon = icon;
    });
  }

  _setDriversMarker(DriversP point) async {
    double lat = double.parse(point.lat);
    double lng = double.parse(point.lng);
    BitmapDescriptor iconValue = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(30, 30)),
      driver,
    );
    setState(() {
      driversMarkers.add(
        Marker(
          markerId: MarkerId("driverMakerId${point.id}"),
          position: LatLng(lat, lng),
          icon: iconValue,
        ),
      );
    });
  }

  Future<void> _goToMyLocation() async {
    final ctrl = await _controller.future;
    final zoom = await ctrl.getZoomLevel();
    await ctrl.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(myPosition.latitude - _levelUp, myPosition.longitude),
          zoom: zoom,
        ),
      ),
    );
  }
}
