import 'package:device_features/screen/sensor/physics/accelerometer_screen.dart';
import 'package:device_features/screen/sensor/physics/barometer_screen.dart';
import 'package:device_features/screen/sensor/physics/gyroscope_screen.dart';
import 'package:device_features/screen/sensor/physics/magnetometer_screen.dart';
import 'package:flutter/material.dart';

import '../../../widget/feature_button.dart';

class PhysicsScreen extends StatelessWidget {
  const PhysicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          FeatureButton(
            label: 'Accelerometer',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccelerometerScreen()),
            ),
          ),
          FeatureButton(
            label: 'Gyroscope',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GyroscopeScreen()),
            ),
          ),
          FeatureButton(
            label: 'Magnetometer',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MagnetometerScreen()),
            ),
          ),
          FeatureButton(
            label: 'Barometer',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BarometerScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
