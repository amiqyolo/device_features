import 'dart:async';

import 'package:device_features/screen/sensor/behavior/sensor_checker.dart';
import 'package:flutter/material.dart';

class ProximityScreen extends StatefulWidget {
  const ProximityScreen({super.key});

  @override
  State<ProximityScreen> createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  final SensorChecker _sensorChecker = SensorChecker();
  bool _isSupported = false;

  @override
  void initState() {
    super.initState();
    _checkSensorSupport();
  }

  Future<void> _checkSensorSupport() async {
    final sensorSupport = await _sensorChecker.checkSensors();
    setState(() {
      _isSupported = sensorSupport["proximity"] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          _isSupported
              ? "Proximity Sensor is Supported\n$_isSupported"
              : "Proximity Sensor is Not Supported\n$_isSupported",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
