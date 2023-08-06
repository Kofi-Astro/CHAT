import 'dart:async';

import './state_abstract_control.dart';

class StateControl implements StateAbstractControl {
  final StreamController streamController;

  StateControl() : streamController = StreamController();

  @override
  void notifyListeners() {
    streamController.add('change');
  }

  @override
  void init() {
    print('Initializing state');
  }

  @override
  void dispose() {
    print('Disposing state');
    streamController.close();
  }
}
