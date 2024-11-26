import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../../widget/feature_button.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  double? _temperature;

  @override
  void initState() {
    super.initState();

    // Sensors_plus tidak memiliki sensor suhu & kelembapan, simulasi nilai.
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _temperature = 27.5; // Simulasi suhu
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Temperature:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_temperature != null ? 'Value: $_temperature °C' : 'Fetching data...'),
          ],
        ),
      ),
    );
  }
}
