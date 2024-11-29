import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BarometerScreen extends StatefulWidget {
  const BarometerScreen({super.key});

  @override
  State<BarometerScreen> createState() => _BarometerScreenState();
}

class _BarometerScreenState extends State<BarometerScreen> {
  BarometerEvent? _pressure;
  late StreamSubscription<BarometerEvent> _subscription;
  bool _isBarometerAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBarometer();
  }

  Future<void> _checkBarometer() async {
    try {
      _subscription = barometerEventStream().listen((pressure) {
        setState(() {
          _isBarometerAvailable = true;
          _pressure = pressure;
        });
      });
    } catch (e) {
      setState(() {
        _isBarometerAvailable = false;
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Barometer supported = $_isBarometerAvailable',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            _pressure != null
                ? Text(
                    'Pressure: ${_pressure!.pressure.toStringAsFixed(2)} hPa',
                    style: const TextStyle(fontSize: 20),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
