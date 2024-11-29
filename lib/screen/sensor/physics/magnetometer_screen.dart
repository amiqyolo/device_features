import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerScreen extends StatefulWidget {
  const MagnetometerScreen({super.key});

  @override
  State<MagnetometerScreen> createState() => _MagnetometerScreenState();
}

class _MagnetometerScreenState extends State<MagnetometerScreen> {
  bool _isMagnetometerAvailable = false;
  late StreamSubscription<MagnetometerEvent> _subscription;
  MagnetometerEvent? _magnetometerEvent;

  @override
  void initState() {
    super.initState();

    _checkMagnetometer();
  }

  Future<void> _checkMagnetometer() async {
    try {
      _subscription = magnetometerEventStream().listen((event) {
        setState(() {
          _isMagnetometerAvailable = true;
          _magnetometerEvent = event;
        });
      });
    } catch (e) {
      setState(() {
        _isMagnetometerAvailable = false;
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
        child: Column(
          children: [
            Text('Magnetometer supported = $_isMagnetometerAvailable',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            _magnetometerEvent != null
                ? Text(
              'X: ${_magnetometerEvent!.x.toStringAsFixed(2)}\n'
                  'Y: ${_magnetometerEvent!.y.toStringAsFixed(2)}\n'
                  'Z: ${_magnetometerEvent!.z.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
                : const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
