import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class BarometerScreen extends StatelessWidget {
  const BarometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barometer Data')),
      body: StreamBuilder<BarometerEvent>(
        stream: barometerEventStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final BarometerEvent event = snapshot.data!;
          return Center(
            child: Text(
              'Barometer Field\nPressure: ${event.pressure.toStringAsFixed(2)}\n'
              'Time Stamp: ${event.timestamp}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
