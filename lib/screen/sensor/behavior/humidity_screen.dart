import 'package:flutter/material.dart';

import '../../../widget/feature_button.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  double? _humidity;

  @override
  void initState() {
    super.initState();

    // Sensors_plus tidak memiliki sensor suhu & kelembapan, simulasi nilai.
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _humidity = 60.0; // Simulasi kelembapan
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
            const Text('Humidity:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_humidity != null ? 'Value: $_humidity %' : 'Fetching data...'),
          ],
        ),
      ),
    );
  }
}
