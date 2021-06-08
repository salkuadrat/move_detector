import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class DrawingState with ChangeNotifier {
  List<List<Offset>> _positions = [];

  List<List<Offset>> get positions => _positions;

  void start(Offset point) {
    _positions.add([point]);
    notifyListeners();
  }

  void draw(Offset point) {
    if (_positions.isNotEmpty) {
      _positions[_positions.length - 1].add(point);
      notifyListeners();
    }
  }

  void stop() {
    notifyListeners();
  }

  void clear() {
    _positions = [];
    notifyListeners();
  }
}
