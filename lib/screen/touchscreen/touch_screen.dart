import 'dart:ui';

import 'package:flutter/material.dart';

class TouchScreen extends StatefulWidget {
  const TouchScreen({super.key});

  @override
  State<TouchScreen> createState() => _TouchScreenState();
}

class _TouchScreenState extends State<TouchScreen> {
  String touchInfo = "Sentuh layar untuk mendapatkan informasi";
  int touchCount = 0;
  double scale = 1.0;
  double rotation = 0.0;

  // void _handleTouch(String action, Offset position) {
  //   setState(() {
  //     touchInfo = "Action $action\nPosition: X=${position.dx} Y=${position.dy}";
  //   });
  // }

  void _handleTouch(PointerEvent event) {
    setState(() {
      touchCount = event.buttons & PointerDeviceKind.touch.index;
      touchInfo =
          'Pointer ID: ${event.pointer}\nPosition: x=${event.localPosition.dx}, y=${event.localPosition.dy}\nTouch Count: $touchCount';
    });
  }

  void _handleScale(ScaleUpdateDetails details) {
    setState(() {
      scale = details.scale;
      rotation = details.rotation;
      touchInfo =
          "Scale: ${scale.toStringAsFixed(2)}\nRotation: ${rotation.toStringAsFixed(2)} radians";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onScaleStart: (details) {
          setState(() {
            touchInfo = "Scaling/Rotating started!";
          });
        },
        onScaleUpdate: _handleScale,
        onScaleEnd: (details) {
          setState(() {
            touchInfo = "Scaling/Rotating ended!";
          });
        },
        onDoubleTap: () {
          setState(() {
            touchInfo = "Double Tap Detected!";
          });
        },
        child: Listener(
          onPointerDown: _handleTouch,
          onPointerUp: _handleTouch,
          onPointerMove: _handleTouch,
          child: Container(
            color: Colors.blue.shade50,
            child: Center(
              child: Text(
                touchInfo,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      // body: GestureDetector(
      //   onTapDown: (details) {
      //     _handleTouch('Tap Down', details.localPosition);
      //   },
      //   onTapUp: (details) {
      //     _handleTouch("Tap Up", details.localPosition);
      //   },
      //   onLongPressStart: (details) {
      //     _handleTouch("Long Press Start", details.localPosition);
      //   },
      //   onPanUpdate: (details) {
      //     _handleTouch("Pan Update", details.localPosition);
      //   },
      //   child: Container(
      //     color: Colors.blue.shade50,
      //     child: Center(
      //       child: Text(
      //         touchInfo,
      //         style: const TextStyle(fontSize: 16),
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
