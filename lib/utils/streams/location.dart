import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/drivers_position.dart';
import '../data_manager.dart';
import '../functions.dart';

class PositionStream {
  final BehaviorSubject<Position> _position = BehaviorSubject();
  final BehaviorSubject<List<DriversP>> _dPositions = BehaviorSubject.seeded(
    [],
  );

  Stream<Position> get position => _position.stream;

  Stream<List<DriversP>> get dPositions => _dPositions.stream;

  void _setPositionStream(Position p) {
    _position.sink.add(p);
  }

  void setDriverPositions(List<DriversP> positions) {
    _dPositions.sink.add(positions);
  }

  startTracking(Position position) async {
    _updatePosition(position);
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position newPos) {
      _updatePosition(newPos);
    });
  }

  void _updatePosition(Position position) {
    _setPositionStream(position);
    getAddressFromCoordinate(
      LatLng(position.latitude, position.longitude),
    ).then((value) {
      if (value == null) return;
      DataManager().placeStream.setOrigin(value);
    });
  }
}
