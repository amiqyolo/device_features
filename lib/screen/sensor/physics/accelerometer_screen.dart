import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatefulWidget {
  const AccelerometerScreen({super.key});

  @override
  State<AccelerometerScreen> createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  bool _isAccelerometerAvailable = false;
  late StreamSubscription<AccelerometerEvent> _subscription;
  AccelerometerEvent? _accelerometerEvent; // sensor plus

  @override
  void initState() {
    super.initState();
    checkSensors();
  }

  Future<void> checkSensors() async {
    try {
      _subscription = accelerometerEventStream().listen((AccelerometerEvent event) {
        setState(() {
          _isAccelerometerAvailable = true;
          _accelerometerEvent = event;
        });
      });
    } catch (e) {
      setState(() {
        _isAccelerometerAvailable = false;
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
      appBar: AppBar(title: const Text('Accelerometer Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isAccelerometerAvailable
            ? _accelerometerEvent != null
                ? Text(
                    'X: ${_accelerometerEvent!.x.toStringAsFixed(2)}\n'
                    'Y: ${_accelerometerEvent!.y.toStringAsFixed(2)}\n'
                    'Z: ${_accelerometerEvent!.z.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : const CircularProgressIndicator()
            : const Text(
                'Accelerometer not supported by this device.',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
