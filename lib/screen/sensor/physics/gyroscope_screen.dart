import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

// Membaca data gyroscope (rotasi)
class GyroscopeScreen extends StatelessWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<GyroscopeEvent>(
        stream: gyroscopeEventStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          final GyroscopeEvent event = snapshot.data!;
          return Center(
            child: Text(
              'Rotation Rate\nX: ${event.x.toStringAsFixed(2)}\n'
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
