import 'package:device_features/screen/sensor/behavior/sensor_checker.dart';
import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
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
      _isSupported = sensorSupport["temperature"] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          _isSupported
              ? "Temperature Sensor is Supported\n$_isSupported"
              : "Temperature Sensor is Not Supported\n$_isSupported",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
