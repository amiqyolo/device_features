import 'dart:async';

import 'package:device_features/screen/sensor/behavior/sensor_checker.dart';
import 'package:flutter/material.dart';

class AmbientLightScreen extends StatefulWidget {
  const AmbientLightScreen({super.key});

  @override
  State<AmbientLightScreen> createState() => _AmbientLightScreenState();
}

class _AmbientLightScreenState extends State<AmbientLightScreen> {
  final SensorChecker _sensorChecker = SensorChecker();
  bool _isLightSensorAvailable = false;

  @override
  void initState() {
    super.initState();

    _checkSensorSupport();
  }

  Future<void> _checkSensorSupport() async {
    final sensorSupport = await _sensorChecker.checkSensors();
    setState(() {
      _isLightSensorAvailable = sensorSupport["ambientLight"] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _isLightSensorAvailable
                ? "Ambient Light Sensor is Supported\n$_isLightSensorAvailable"
                : "Ambient Light Sensor is Not Supported\n$_isLightSensorAvailable",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
