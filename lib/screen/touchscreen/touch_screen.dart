import 'package:flutter/material.dart';

class TouchScreen extends StatefulWidget {
  const TouchScreen({super.key});

  @override
  State<TouchScreen> createState() => _TouchScreenState();
}

class _TouchScreenState extends State<TouchScreen> {
  String touchInfo = "Sentuh layar untuk mendapatkan informasi";

  void _handleTouch(String action, Offset position) {
    setState(() {
      touchInfo = "Action $action\nPosition: X=${position.dx} Y=${position.dy}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTapDown: (details) {
          _handleTouch('Tap Down', details.localPosition);
        },
        onTapUp: (details) {
          _handleTouch("Tap Up", details.localPosition);
        },
        onLongPressStart: (details) {
          _handleTouch("Long Press Start", details.localPosition);
        },
        onPanUpdate: (details) {
          _handleTouch("Pan Update", details.localPosition);
        },
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
    );
  }
}
