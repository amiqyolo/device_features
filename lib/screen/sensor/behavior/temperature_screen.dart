import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../widget/feature_button.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  // Environment not support
  // final environmentSensors = EnvironmentSensors();
  double? _temperature;
  double? _humidity;
  bool _isSensorAvailable = false;

  @override
  void initState() {
    super.initState();

    _checkSensors();
  }

  Future<void> _checkSensors() async {
    try {
      // final hasSensor = await environmentSensors
      //     .getSensorAvailable(SensorType.AmbientTemperature);
      // if (hasSensor) {
      //   environmentSensors.temperature.listen((temp) {
      //     setState(() {
      //       _isSensorAvailable = true;
      //       _temperature = temp;
      //     });
      //   });
      // }
    } catch (e) {
      setState(() {
        _isSensorAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isSensorAvailable
            ? _temperature != null
                ? Text(
                    'Temperature: ${_temperature!.toStringAsFixed(2)} °C',
                    style: const TextStyle(fontSize: 20),
                  )
                : const CircularProgressIndicator()
            : const Text(
                'Temperature Sensors not supported.',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
