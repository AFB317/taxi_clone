import 'package:rxdart/rxdart.dart';

import '../../models/direction.dart';
import '../../models/place.dart';

class PlaceStream {
  final BehaviorSubject<Place> _origin = BehaviorSubject();
  final BehaviorSubject<Place> _destination = BehaviorSubject();

  final BehaviorSubject<List<Direction>> _direction =
  BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Place>> _places = BehaviorSubject.seeded([]);

  Stream<Place> get origin => _origin.stream;

  Stream<Place> get destination => _destination.stream;

  Stream<List<Direction>> get direction => _direction.stream;

  Stream<List<Place>> get places => _places.stream;

  void setOrigin(Place place) {
    _origin.sink.add(place);
  }

  void setDestination(Place place) {
    _destination.sink.add(place);
  }

  void setDirection(List<Direction> direction) {
    _direction.sink.add(direction);
  }

  void setPlaces(List<Place> places) {
    _places.sink.add(places);
  }
}
