library move_detector;

import 'package:flutter/widgets.dart';

/// Widget to detect movement on screen
class MoveDetector extends StatefulWidget {
  /// Widget to detect movement on screen
  MoveDetector({
    required this.child,
    this.onStart,
    this.onUpdate,
    this.onEnd,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// A pointer has contacted the screen and starting to move.
  final Function(MoveDetails details)? onStart;

  /// A pointer that was previously in contact with the screen and moving
  /// is no longer in contact with the screen.
  final Function(MoveDetails details)? onUpdate;

  /// A pointer that is in contact with the screen has made a move.
  final Function(MoveDetails details)? onEnd;

  @override
  _MoveDetectorState createState() => _MoveDetectorState();
}

class _MoveDetectorState extends State<MoveDetector> {
  Offset? _lastPoint;
  Offset? _lastLocalPoint;

  Offset? _lastDelta;
  Offset? _lastLocalDelta;

  _onStart(ScaleStartDetails details) {
    Offset delta = Offset(0, 0);
    Offset localDelta = Offset(0, 0);

    _lastPoint = details.focalPoint;
    _lastLocalPoint = details.localFocalPoint;

    widget.onStart?.call(MoveDetails(
      position: details.focalPoint,
      localPosition: details.localFocalPoint,
      delta: delta,
      localDelta: localDelta,
    ));
  }

  _onUpdate(ScaleUpdateDetails details) {
    if (_lastPoint != null && _lastLocalPoint != null) {
      Offset delta = Offset(
        (details.focalPoint.dx - _lastPoint!.dx).abs(),
        (details.focalPoint.dy - _lastPoint!.dy).abs(),
      );

      Offset localDelta = Offset(
        (details.localFocalPoint.dx - _lastLocalPoint!.dx).abs(),
        (details.localFocalPoint.dy - _lastLocalPoint!.dy).abs(),
      );

      _lastPoint = details.focalPoint;
      _lastLocalPoint = details.localFocalPoint;
      _lastDelta = delta;
      _lastLocalDelta = delta;

      widget.onUpdate?.call(MoveDetails(
        position: details.focalPoint,
        localPosition: details.localFocalPoint,
        delta: delta,
        localDelta: localDelta,
      ));
    }
  }

  _onEnd(ScaleEndDetails details) {
    if (_lastPoint != null &&
        _lastLocalPoint != null &&
        _lastDelta != null &&
        _lastLocalDelta != null) {
      widget.onEnd?.call(MoveDetails(
        position: _lastPoint!,
        localPosition: _lastLocalPoint!,
        delta: _lastDelta!,
        localDelta: _lastLocalDelta!,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onScaleStart: _onStart,
      onScaleUpdate: _onUpdate,
      onScaleEnd: _onEnd,
    );
  }
}

/// The pointer has moved with respect to the device while the pointer is in
/// contact with the device.
///
/// See also:
///
///  * [MoveDetector.onUpdate], which allows callers to be notified of these
///    movement in a widget tree.
///  * [MoveDetector.onStart], which allows callers to be notified for the first time this move occurs
///  * [MoveDetector.onEnd], which allows callers to be notified after the last move occurs.
class MoveDetails {
  /// The [position] transformed into the event receiver's local coordinate
  /// system.
  ///
  /// See also:
  ///
  ///  * [position], which is the position in the global coordinate system of
  ///    the screen.
  final Offset localPosition;

  /// Coordinate of the position of the pointer, in logical pixels in the global
  /// coordinate space.
  ///
  /// See also:
  ///
  ///  * [localPosition], which is the [position] transformed into the local
  ///    coordinate system of the event receiver.
  final Offset position;

  /// The [delta] transformed into the event receiver's local coordinate
  /// system.
  ///
  /// See also:
  ///
  ///  * [delta], which is the distance the pointer moved in the global
  ///    coordinate system of the screen.
  final Offset localDelta;

  /// Distance in logical pixels that the pointer moved since the last
  /// [MoveEvent].
  ///
  /// See also:
  ///
  ///  * [localDelta], which is the [delta] transformed into the local
  ///    coordinate space of the event receiver.
  final Offset delta;

  const MoveDetails(
      {required this.localPosition,
      required this.position,
      required this.localDelta,
      required this.delta});
}
