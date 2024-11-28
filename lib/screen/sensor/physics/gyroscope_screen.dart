import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

// Membaca data gyroscope (rotasi)
class GyroscopeScreen extends StatefulWidget {
  const GyroscopeScreen({super.key});

  @override
  State<GyroscopeScreen> createState() => _GyroscopeScreenState();
}

class _GyroscopeScreenState extends State<GyroscopeScreen> {
  bool _isGyroscopeAvailable = false;
  late StreamSubscription<GyroscopeEvent> _subscription;
  GyroscopeEvent? _gyroscopeEvent;

  @override
  void initState() {
    super.initState();
    _checkGyroscope();
  }

  Future<void> _checkGyroscope() async {
    try {
      _subscription = gyroscopeEventStream().listen((event) {
        setState(() {
          _isGyroscopeAvailable = true;
          _gyroscopeEvent = event;
        });
      });
    } catch (e) {
      setState(() {
        _isGyroscopeAvailable = false;
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isGyroscopeAvailable
            ? _gyroscopeEvent != null
                ? Text(
                    'X: ${_gyroscopeEvent!.x.toStringAsFixed(2)}\n'
                    'Y: ${_gyroscopeEvent!.y.toStringAsFixed(2)}\n'
                    'Z: ${_gyroscopeEvent!.z.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : const CircularProgressIndicator()
            : const Text('Gyroscope not supported by this device.',
                style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
