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

  @override
  void initState() {
    super.initState();

    _accelerometerSubscription =
        accelerometerEventStream().listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          _accelerometerEvent = event;
        });
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel(); // Membatalkan stream listener
    super.dispose();
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
            const Text('Proximity (proximity_plugin):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Value: $_proximityValue'),
            const SizedBox(height: 16.0),
            const Text('Accelerometer (sensors_plus):',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_accelerometerEvent != null
                ? 'X: ${_accelerometerEvent!.x}, Y: ${_accelerometerEvent!.y}, Z: ${_accelerometerEvent!.z}'
                : 'Fetching data...'),
          ],
        ),
      ),
    );
  }
}
