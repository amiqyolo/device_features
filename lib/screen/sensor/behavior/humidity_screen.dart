import 'package:flutter/material.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  // Environment not support
  // final environmentSensors = EnvironmentSensors();
  double? _humidity;
  bool _isSensorAvailable = false;

  @override
  void initState() {
    super.initState();

    _checkSensors();
  }

  Future<void> _checkSensors() async {
    try {
      // final hasSensor =
      //     await environmentSensors.getSensorAvailable(SensorType.Humidity);
      // if (hasSensor) {
      //   environmentSensors.humidity.listen((hum) {
      //     setState(() {
      //       _isSensorAvailable = true;
      //       _humidity = hum;
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
            ? _humidity != null
                ? Text(
                    'Humidity: ${_humidity!.toStringAsFixed(2)} °C',
                    style: const TextStyle(fontSize: 20),
                  )
                : const CircularProgressIndicator()
            : const Text(
                'Humidity Sensors not supported.',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}
