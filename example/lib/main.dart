import 'package:flutter/material.dart';
import 'package:move_detector/move_detector.dart';
import 'package:provider/provider.dart';
import 'painter.dart';
import 'state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoveDetector Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => DrawingState(),
        child: DrawingPage(),
      ),
    );
  }
}

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  DrawingState get state => context.read<DrawingState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MoveDetector(
              onStart: (MoveDetails details) {
                //print(details.localPosition);
                state.start(details.localPosition);
              },
              onUpdate: (MoveDetails details) {
                //print(details.localPosition);
                state.draw(details.localPosition);
              },
              onEnd: (MoveDetails details) {
                //print(details.localPosition);
                state.stop();
              },
              child: Consumer<DrawingState>(
                builder: (_, state, __) => CustomPaint(
                  painter: DrawingPainter(positions: state.positions),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 480,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: Text('Clear Canvas'),
                onPressed: state.clear,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
