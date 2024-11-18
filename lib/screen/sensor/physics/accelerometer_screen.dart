import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatelessWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accelerometer Data')),
      body: StreamBuilder<AccelerometerEvent>(
        stream: accelerometerEventStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final AccelerometerEvent event = snapshot.data!;
          return Center(
            child: Text(
              'X: ${event.x.toStringAsFixed(2)}\n'
              'Y: ${event.y.toStringAsFixed(2)}\n'
              'Z: ${event.z.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
