# Move Detector

The easy way to detect touch movements on screen in Flutter.

## Getting Started

Add dependency to your project.

```
$ flutter pub add move_detector
```

or 

```yaml
dependencies:
  move_detector: ^0.0.1
```

Then run `flutter pub get`.

### Usage

Here is a simple way of using `MoveDetector`.

```dart
import 'package:move_detector/move_detector.dart';
```

```dart
MoveDetector(
  child: ..., // your child widget
  onStart: (MoveEvent event) {
    // do something when pointer on screen starting to move
  },
  onUpdate: (MoveEvent event) {
    // do something when pointer on screen is moving
  },
  onEnd: (MoveEvent event) {
    // do something when pointer on screen stop moving
  },
)
```

And here is the details of each `MoveEvent`.

```dart
// Coordinate of the position of the pointer, 
// in logical pixels in the global coordinate space.
Offset position 

// The [position] transformed into the local coordinate system.
Offset localPosition

// Distance in logical pixels that the pointer has moved since the last [MoveEvent].
Offset delta

// The [delta] transformed into the local coordinate system.
Offset localDelta
```

## Example

Check out example project [here](example). You can also try the working application: [MoveDetector.apk](MoveDetector.apk).