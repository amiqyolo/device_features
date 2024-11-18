import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerScreen extends StatelessWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magnetometer Data')),
      body: StreamBuilder<MagnetometerEvent>(
        stream: magnetometerEventStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final MagnetometerEvent event = snapshot.data!;
          return Center(
            child: Text(
              'Magnetic Field\nX: ${event.x.toStringAsFixed(2)}\n'
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
