import 'package:device_features/screen/sensor/behavior/sensor_checker.dart';
import 'package:flutter/material.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
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
      _isSupported = sensorSupport["humidity"] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          _isSupported
              ? "Humidity Sensor is Supported\n$_isSupported"
              : "Humidity Sensor is Not Supported\n$_isSupported",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
