import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ProximityScreen extends StatefulWidget {
  const ProximityScreen({super.key});

  @override
  State<ProximityScreen> createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  String _proximityValue = 'Unknown'; // Proximity plugin
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  AccelerometerEvent? _accelerometerEvent; // sensor plus

  void _startProximitySensor() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      // Contoh pengolahan sederhana untuk mendeteksi proximity
      if (event.z < 1.0) {
        setState(() {
          _proximityValue = "Object detected nearby";
        });
      } else {
        setState(() {
          _proximityValue = "No object nearby";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _startProximitySensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          _proximityValue,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
