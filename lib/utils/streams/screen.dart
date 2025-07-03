import 'package:rxdart/rxdart.dart';

import '../enumerations.dart';

class ScreenStateStream {
  final BehaviorSubject<ScreenState> _screenState = BehaviorSubject.seeded(
    ScreenState.initial,
  );

  Stream<ScreenState> get screenState => _screenState.stream;

  void setScreenState(ScreenState state) {
    _screenState.sink.add(state);
  }
}
